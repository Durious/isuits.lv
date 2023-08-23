<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <link rel="icon" href="/icon-48.png" />
  <link rel="manifest" href="/manifest.json" />
  <meta name="theme-color" content="#1A202C" />
  <link rel="icon" sizes="48x48" href="/icon-48.png" />
  <link rel="icon" sizes="96x96" href="/icon-96.png" />
  <link rel="icon" sizes="144x144" href="/icon-144.png" />
  <link rel="icon" sizes="192x192" href="/icon-192.png" />
  <link rel="icon" sizes="512x512" href="/icon-512.png" />
  <link rel="apple-touch-icon" href="/icon-76.png" />
  <link rel="apple-touch-icon" sizes="76x76" href="/icon-76.png" />
  <link rel="apple-touch-icon" sizes="120x120" href="/icon-120.png" />
  <link rel="apple-touch-icon" sizes="152x152" href="/icon-152.png" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  @if (demo())
    <meta name="description"
      content="TSMS (Tailor Shop Management System) is developer for small and medium sized tailoring business need to manage customers, measurements, orders and payments." />
    <meta name="keywords" content="Tecdiary, TailotShop, Tailor, Business, CRM, Expenses" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://tsms.tecdiary.net/login" />
    <meta property="og:title" content="Tailor Shop Management System (TSMS)" />
    <meta property="og:image:height" content="995" />
    <meta property="og:image:width" content="1920" />
    <meta property="og:image" content="https://tsms.tecdiary.net/img/dashboard.png" />
    <meta property="og:description"
      content="TSMS (Tailor Shop Management System) is developer for small and medium sized tailoring business need to manage customers, measurements, orders and payments." />
  @endif
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <title inertia>{{ config('app.name', 'Tailor Shop Management System (TSMS)') }}</title>

  <!-- Scripts -->
  {!! '<script>var Locale = "' . app()->getLocale() . '";</script>' !!}
  <style>
    .app-loading {
      top: 0px;
      left: 0px;
      right: 0px;
      bottom: 0px;
      width: 100%;
      z-index: 40;
      display: flex;
      position: fixed;
      min-height: 100vh;
      align-items: center;
      flex-direction: column;
      justify-content: center;
    }

    .app-loading.bg-gray-50 {
      --tw-bg-opacity: 1;
      background-color: rgb(249 250 251 / var(--tw-bg-opacity));
    }

    .dark .app-loading.dark\:bg-gray-900 {
      --tw-bg-opacity: 1;
      background-color: rgb(17 24 39 / var(--tw-bg-opacity));
    }

    .app-loading svg {
      --tw-text-opacity: 1;

      width: 3rem;
      height: 3rem;
      animation: spin 1s linear infinite;
      color: rgb(31 41 55 / var(--tw-text-opacity));
    }

    .dark .app-loading svg {
      color: rgb(229 231 235 / var(--tw-text-opacity));
    }

    @keyframes spin {
      from {
        transform: rotate(0deg);
      }

      to {
        transform: rotate(360deg);
      }
    }
  </style>
  @routes
  @vite('resources/js/app.js')
  @inertiaHead
</head>

<body dir="ltr" class="h-full bg-gray-200 font-sans leading-none text-gray-700 antialiased">
  <div id="app-loading" class="app-loading bg-gray-50 dark:bg-gray-900">
    <svg width="64" height="64" fill="none" viewBox="0 0 16 16">
      <circle cx="8" cy="8" r="7" stroke-width="2" stroke="currentColor" stroke-opacity="0.25"
        vector-effect="non-scaling-stroke"></circle>
      <path d="M15 8a7.002 7.002 0 00-7-7" stroke="currentColor" stroke-width="2" stroke-linecap="round" vector-effect="non-scaling-stroke">
      </path>
    </svg>
  </div>
  @inertia
</body>

</html>
