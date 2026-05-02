/*
This file is part of ssXchat Desktop,
the official desktop application for the ssXchat messaging service.

For license and copyright information please follow this link:
https://github.com/supersonic-xserver/ssXchat-desktop/blob/master/LEGAL
*/
#include "data/data_abstract_structure.h"

#include "base/never_freed_pointer.h"

namespace Data {
namespace {

using DataStructures = OrderedSet<AbstractStructure**>;
base::NeverFreedPointer<DataStructures> structures;

} // namespace

namespace internal {

void registerAbstractStructure(AbstractStructure **p) {
	structures.createIfNull();
	structures->insert(p);
}

} // namespace internal

void clearGlobalStructures() {
	if (!structures) return;
	for (auto &p : *structures) {
		delete (*p);
		*p = nullptr;
	}
	structures.clear();
}

} // namespace Data
