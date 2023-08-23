@php
    $output = [];
    foreach ($customer_measure_list as $customer_measure_item) {
        foreach ($customer_measure_item as $key => $value) {
            $output[$key] = json_decode($value);
            if (is_int($output[$key])) {
                $output[$key] = $output[$key] . '';
            }
            if (is_object($output[$key])) {
                $output[$key] = get_object_vars($output[$key]);
            }
        }
    }
@endphp
@foreach ($fields as $field_item)
    <div class="my-3">
        <div class="mb-2 font-weight-bold">{{ $field_item->name }}</div>
        @if ($field_item->type === 'Text')
            <input type="text" name="{{ $field_item->name }}" class="w-100" value="{{ ($output[$field_item->name] ?? null) }}" />
        @elseif($field_item->type === 'Radio')
            @foreach ($field_item->options as $option_item)
                <div>
                    <input type="radio" name="{{ $field_item->name }}"
                        id="{{ $field_item->name }}-{{ $option_item['value'] }}" value="{{ $option_item['value'] }}"
                        {{ ($output[$field_item->name] ?? null) === $option_item['value'] ? 'checked' : '' }} />
                    <label
                        for="{{ $field_item->name }}-{{ $option_item['value'] }}">{{ $option_item['value'] }}</label>
                </div>
            @endforeach
        @elseif($field_item->type === 'Checkbox')
            @foreach ($field_item->options as $option_item)
                <div>
                    <input type="checkbox" name="{{ $field_item->name }}" value="{{ $option_item['value'] }}"
                        id="{{ $field_item->name }}-{{ $option_item['value'] }}"
                        {{ ($output[$field_item->name][$option_item['value']] ?? false) ? 'checked' : '' }} />
                    <label
                        for="{{ $field_item->name }}-{{ $option_item['value'] }}">{{ $option_item['value'] }}</label>
                </div>
            @endforeach
        @elseif($field_item->type === 'Select')
            <select class="w-100" name="{{ $field_item->name }}">
                @foreach ($field_item->options as $option_item)
                    <option value="{{ $option_item['value'] }}"
                        {{ ($output[$field_item->name] ?? null) === $option_item['value'] ? 'selected' : '' }}>
                        {{ $option_item['value'] }}
                    </option>
                @endforeach
            </select>
        @elseif($field_item->type === 'Textarea')
            <textarea name="{{ $field_item->name }}" class="w-100">{{ $output[$field_item->name] ?? null }}</textarea>
        @endif
        <div>{{ $field_item->description }}</div>
    </div>
@endforeach
