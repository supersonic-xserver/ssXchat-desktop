/*
This file is part of ssXchat Desktop,
the official desktop application for the ssXchat messaging service.

For license and copyright information please follow this link:
https://github.com/supersonic-xserver/ssXchat-desktop/blob/master/LEGAL
*/
#include "export/output/export_output_stats.h"

namespace Export {
namespace Output {

Stats::Stats(const Stats &other)
: _files(other._files.load())
, _bytes(other._bytes.load()) {
}

void Stats::incrementFiles() {
	++_files;
}

void Stats::incrementBytes(int count) {
	_bytes += count;
}

int Stats::filesCount() const {
	return _files;
}

int64 Stats::bytesCount() const {
	return _bytes;
}

} // namespace Output
} // namespace Export
