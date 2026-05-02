/*
This file is part of ssXchat Desktop,
the official desktop application for the ssXchat messaging service.

For license and copyright information please follow this link:
https://github.com/supersonic-xserver/ssXchat-desktop/blob/master/LEGAL
*/
#include "history/view/history_view_quick_action.h"

#include "core/application.h"
#include "core/core_settings.h"

namespace HistoryView {

DoubleClickQuickAction CurrentQuickAction() {
	return Core::App().settings().chatQuickAction();
}

} // namespace HistoryView
