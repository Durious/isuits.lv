<?php

namespace App\Helpers;

use App\Models\Category;
use Carbon\Carbon;
use App\Models\Order;
use App\Models\Salary;
use App\Models\Expense;
use App\Models\Customer;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class TableIOHelper
{
    protected static function str_putcsv($row, $delimiter = ',', $enclosure = '"', $escape_char = "\\")
    {
        $output = [];
        foreach ($row as $field) {
            array_push($output, $enclosure . str_replace($enclosure, $escape_char . $enclosure, $field) . $enclosure);
        }
        return $output;
    }

    public static function export2CSV($tableName, $fields)
    {
        $rows = DB::table($tableName)->select($fields)->get()->toArray();

        $rows = TableIOHelper::activeNum2Str($fields, $rows);
        $rows = TableIOHelper::categoryIdNum2Str($fields, $rows);

        $tableContent = implode(',', $fields) . "\n";
        foreach ($rows as $row) {
            $values = TableIOHelper::str_putcsv(get_object_vars($row));
            $tableContent .= implode(',', $values) . "\n";
        }

        return $tableContent;
    }

    public static function activeNum2Str($fields, $rows)
    {
        if (in_array('active', $fields)) {
            foreach ($rows as $row) {
                $row->active = $row->active == 1 ? 'active' : 'inactive';
            }
        }

        return $rows;
    }

    public static function categoryIdNum2Str($fields, $rows)
    {
        if (in_array('category_id', $fields)) {
            foreach ($rows as $row) {
                $row->category_id = Category::find($row->category_id)->name;
            }
        }

        return $rows;
    }

    public static function activeStr2Num($fields, $rows)
    {
        $key = array_search('active', $fields);

        $newRows = [];

        if ($key !== false) {
            if (in_array('active', $fields)) {
                foreach ($rows as $row) {
                    $row[$key] = $row[$key] == 'active' ? 1 : 0;
                    $newRows[] = $row;
                }
            }
        } else {
            return $rows;
        }

        return $newRows;
    }

    public static function categoryIdStr2Num($fields, $rows)
    {
        $key = array_search('category_id', $fields);

        $newRows = [];

        if ($key !== false) {
            if (in_array('category_id', $fields)) {
                foreach ($rows as $row) {
                    $row[$key] = Category::where('name', $row[$key])->first()->id;
                    $newRows[] = $row;
                }
            }
        } else {
            return $rows;
        }

        return $newRows;
    }

    public static function updateTable($tableName, $fields, $rows)
    {
        $rows = TableIOHelper::activeStr2Num($fields, $rows);
        $rows = TableIOHelper::categoryIdStr2Num($fields, $rows);

        $insert_values = array();
        $update_values = array();
        $params = array();

        foreach ($rows as $data) {
            $insert_values[] = '(' . implode(', ', array_fill(0, count($data), '?')) . ')';

            $update_value = '';
            foreach ($data as $index => $value) {
                $update_value .= "$fields[$index] = VALUES($fields[$index]), ";
                $params[] = $value;
            }
            $update_value .= "updated_at = NOW()";

            $update_values[] = $update_value;
        }

        $fieldList = implode(',', $fields);

        $insert_query = "INSERT INTO {$tableName} ($fieldList) VALUES " . implode(",", $insert_values);
        $update_query = " ON DUPLICATE KEY UPDATE " . implode(",", $update_values);

        $query = $insert_query . $update_query;

        try {
            $stmt = DB::connection()->getPdo()->prepare($query);
            $stmt->execute($params);

            $affectedRows = $stmt->rowCount();

            $rowCnt = count($rows);

            $updated_rows = $affectedRows - $rowCnt;
            $inserted_rows = $rowCnt - $updated_rows;

            return [$inserted_rows, $updated_rows];
        } catch (\Illuminate\Database\QueryException $exception) {
            return $exception->getMessage();
        } catch (\PDOException $exception) {
            // Handle PDOException here
            return $exception->getMessage();
        }
    }

    public static function importFromCSV($request, $tableName)
    {
        $insertedCnt = 0;
        $updatedCnt = 0;

        $fileName = time() . '.' . $request->csv->extension();
        $request->csv->storeAs('public/product', $fileName);

        // Open the CSV file for reading
        $file = fopen(storage_path("app/public/product/{$fileName}"), 'r');

        // Read the first row of the CSV file
        $row = fgetcsv($file);

        // Remove the BOM if it is present
        if (strpos($row[0], "\xEF\xBB\xBF") === 0) {
            $row[0] = substr($row[0], 3);
        }

        // Use the modified row as field names
        $fields = $row;

        $rows = [];

        // Iterate over the remaining rows and create/update Product records
        while (($row = fgetcsv($file)) !== false) {
            $rows[] = $row;

            if (count($rows) > 110) {
                $result = TableIOHelper::updateTable($tableName, $fields, $rows);
                if (is_array($result)) {
                    $insertedCnt += $result[0];
                    $updatedCnt += $result[1];
                } else {
                    return $result;
                }
            }
        }

        if (count($rows) != 0) {
            $result = TableIOHelper::updateTable($tableName, $fields, $rows);
            if (is_array($result)) {
                $insertedCnt += $result[0];
                $updatedCnt += $result[1];
            } else {
                return $result;
            }
        }

        // Close the CSV file
        fclose($file);

        return [$insertedCnt, $updatedCnt];
    }
}
