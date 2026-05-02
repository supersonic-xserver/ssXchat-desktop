/*
This file is part of ssXchat Desktop,
the official desktop application for the ssXchat messaging service.

For license and copyright information please follow this link:
https://github.com/supersonic-xserver/ssXchat-desktop/blob/master/LEGAL
*/
#include "stripe/stripe_decode.h"

namespace Stripe {

[[nodiscard]] bool ContainsFields(
		const QJsonObject &object,
		std::vector<QStringView> keys) {
	for (const auto &key : keys) {
		if (object.value(key).isUndefined()) {
			return false;
		}
	}
	return true;
}

} // namespace Stripe
