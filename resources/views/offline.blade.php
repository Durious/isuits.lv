<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ config('app.name') }}</title>
    <style>
        html, body {
            margin: 0;
            height: 100vh;
            color: #636b6f;
            font-weight: 200;
            background-color: #fff;
            font-family: Cerebri Sans, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
        }

        .full-height {
            height: 100vh;
        }

        .flex-center {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .content {
            margin: auto;
            text-align: center;
        }

        .title {
            font-size: 24px;
        }

        .m-b-md {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="flex-center full-height">
        <div class="content">
            <div class="title m-b-md">
                <img src="{{ asset('img/logo.svg') }}" alt="{{ config('app.name') }}" style="width:300px;" />
                <p>Sorry! the page you have requested is not available in <strong>offline-mode</strong>.</p>
                <p>Please check your <strong>network connection</strong> and try again.</p>
            </div>
        </div>
    </div>
</body>
</html>
