/*
ssXchat Privacy Hardening
This file provides privacy-respecting overrides for device information.
*/
#pragma once

#include <QString>

namespace Platform {

// ssXchat privacy: Return generic device info to prevent fingerprinting
// These override the real OS/hardware detection

inline QString DeviceModelPretty() {
#ifdef TDESKTOP_GENERIC_DEVICE_INFO
	return u"PC"_q;
#else
	// This will be defined by platform-specific code
	// Fallback for the generic case
	return u"Linux"_q;
#endif
}

inline QString SystemVersionPretty() {
#ifdef TDESKTOP_GENERIC_DEVICE_INFO
	// Generic Linux system version - identical for all users
	return u"5.10.0"_q;
#else
	// This will be defined by platform-specific code
	// Fallback for the generic case
	return u"Linux"_q;
#endif
}

} // namespace Platform