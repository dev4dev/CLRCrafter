#!/bin/bash

#  extract-binary.sh
#  CLRCrafter
#
#  Created by Alex Antonyuk on 12/22/16.
#  Copyright © 2016 Alex Antonyuk. All rights reserved.

cp -v "${BUILT_PRODUCTS_DIR}/${EXECUTABLE_PATH}" "${SRCROOT}/binary/${EXECUTABLE_NAME}"

rm -Rvf "${SRCROOT}/binary/CLRCrafterFramework.framework"
cp -Rv "${CONFIGURATION_BUILD_DIR}/CLRCrafterFramework.framework" "${SRCROOT}/binary/"

rm -Rvf "${SRCROOT}/binary/Frameworks"
cp -Rv "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/Contents/Frameworks" "${SRCROOT}/binary/"
