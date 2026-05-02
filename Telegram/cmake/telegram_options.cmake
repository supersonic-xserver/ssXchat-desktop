# This file is part of Telegram Desktop,
# the official desktop application for the Telegram messaging service.
#
# For license and copyright information please follow this link:
# https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL

option(TDESKTOP_API_TEST "Use test API credentials." OFF)
set(TDESKTOP_API_ID "0" CACHE STRING "Provide 'api_id' for the Telegram API access.")
set(TDESKTOP_API_HASH "" CACHE STRING "Provide 'api_hash' for the Telegram API access.")

if (TDESKTOP_API_TEST)
    set(TDESKTOP_API_ID 17349)
    set(TDESKTOP_API_HASH 344583e45741c457fe1862106095a5eb)
endif()

if (TDESKTOP_API_ID STREQUAL "0" OR TDESKTOP_API_HASH STREQUAL "")
    message(FATAL_ERROR
    " \n"
    " PROVIDE: -D TDESKTOP_API_ID=[API_ID] -D TDESKTOP_API_HASH=[API_HASH]\n"
    " \n"
    " > To build your version of Telegram Desktop you're required to provide\n"
    " > your own 'api_id' and 'api_hash' for the Telegram API access.\n"
    " >\n"
    " > How to obtain your 'api_id' and 'api_hash' is described here:\n"
    " > https://core.telegram.org/api/obtaining_api_id\n"
    " >\n"
    " > If you're building the application not for deployment,\n"
    " > but only for test purposes you can use TEST ONLY credentials,\n"
    " > which are very limited by the Telegram API server:\n"
    " >\n"
    " > api_id: 17349\n"
    " > api_hash: 344583e45741c457fe1862106095a5eb\n"
    " >\n"
    " > Your users will start getting internal server errors on login\n"
    " > if you deploy an app using those 'api_id' and 'api_hash'.\n"
    " ")
endif()

if (DESKTOP_APP_DISABLE_AUTOUPDATE)
    target_compile_definitions(Telegram PRIVATE TDESKTOP_DISABLE_AUTOUPDATE)
endif()

if (DESKTOP_APP_DISABLE_CRASH_REPORTS)
    target_compile_definitions(Telegram PRIVATE TDESKTOP_DISABLE_CRASH_REPORTS)
endif()

if (DESKTOP_APP_USE_PACKAGED)
    target_compile_definitions(Telegram PRIVATE TDESKTOP_USE_PACKAGED)
endif()

if (DESKTOP_APP_SPECIAL_TARGET)
    target_compile_definitions(Telegram PRIVATE TDESKTOP_ALLOW_CLOSED_ALPHA)
endif()

option(DESKTOP_APP_DISABLE_SWIFT6 "Disable local on-device translation (build without Swift 6 on macOS)." OFF)
if (DESKTOP_APP_DISABLE_SWIFT6)
    target_compile_definitions(Telegram PRIVATE TDESKTOP_DISABLE_SWIFT6)
endif()

# ssXchat Privacy Hardening Options
option(DESKTOP_APP_DISABLE_WAYLAND "Force X11 mode, disable Wayland support for privacy and latency." ON)
option(DESKTOP_APP_SOVEREIGN_BUILD "Sovereign build mode - enables all privacy hardening flags." ON)
option(DESKTOP_APP_GENERIC_DEVICE_INFO "Use generic device model/version for privacy." ON)

if(DESKTOP_APP_SOVEREIGN_BUILD)
    set(DESKTOP_APP_DISABLE_WAYLAND ON)
    set(DESKTOP_APP_DISABLE_AUTOUPDATE ON)
    set(DESKTOP_APP_DISABLE_CRASH_REPORTS ON)
    set(DESKTOP_APP_GENERIC_DEVICE_INFO ON)
    message(STATUS "ssXchat: Building in sovereign/privacy-hardened mode")
endif()

if (DESKTOP_APP_GENERIC_DEVICE_INFO)
    target_compile_definitions(Telegram PRIVATE TDESKTOP_GENERIC_DEVICE_INFO)
endif()

if (DESKTOP_APP_DISABLE_WAYLAND)
    # ssXchat: Explicitly disable Wayland to prevent X11/XAA performance issues
    # and potential fingerprinting through Wayland compositor leaks
    target_compile_definitions(Telegram PRIVATE TDESKTOP_DISABLE_WAYLAND)
    
    # Add build-time check for wayland libraries
    if(UNIX AND NOT APPLE)
        find_package(PkgConfig QUIET)
        if(PkgConfig_FOUND)
            pkg_check_modules(WAYLAND wayland-client wayland-cursor wayland-egl QUIET)
            if(WAYLAND_FOUND)
                message(FATAL_ERROR "ssXchat build aborted: Wayland libraries detected! "
                    "ssXchat requires X11-only builds. Please unset WAYLAND_DISPLAY "
                    "or remove libwayland packages before building.")
            endif()
        endif()
    endif()
endif()

# ssXchat: Disable telemetry-related features
if (NOT DESKTOP_APP_SOVEREIGN_BUILD)
    # Only apply if not already set via sovereign build
    if (DESKTOP_APP_DISABLE_AUTOUPDATE)
        target_compile_definitions(Telegram PRIVATE TDESKTOP_DISABLE_AUTOUPDATE)
    endif()
    if (DESKTOP_APP_DISABLE_CRASH_REPORTS)
        target_compile_definitions(Telegram PRIVATE TDESKTOP_DISABLE_CRASH_REPORTS)
    endif()
endif()
