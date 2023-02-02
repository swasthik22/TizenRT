#!/usr/bin/env bash
###########################################################################
#
# Copyright 2023 Samsung Electronics All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#
###########################################################################
# mk_memory_regioninfo.sh


OSTOOLDIR=`test -d ${0%/*} && cd ${0%/*}; pwd`
OSDIR="${OSTOOLDIR}/.."
CONFIGFILE="${OSDIR}/.config"
source ${CONFIGFILE}
SEARCH_REGION_C_FILE_PATH=${OSDIR}/kernel/debug/memory_regioninfo.c

printf '%s\n' "/* Automatically generated file; DO NOT EDIT. */">${SEARCH_REGION_C_FILE_PATH}
printf '%s\n\n' "#include <sys/types.h>" >> ${SEARCH_REGION_C_FILE_PATH}

printf '%s\n%s\n\n' "extern uint32_t _sbss;" "extern uint32_t _ebss;" >> ${SEARCH_REGION_C_FILE_PATH}
printf '%s\n%s\n\n' "extern uint32_t _sdata;" "extern uint32_t _edata;" >> ${SEARCH_REGION_C_FILE_PATH}

echo "Printing from the sh script"
echo "${CONFIG_ARCH_BOARD_RTL8720E}"

if [[ "${CONFIG_ARCH_BOARD_RTL8720E}" == "y" ]]; then
	printf '%s\n%s\n\n' "extern uint32_t __bss_start__;" "extern uint32_t __bss_end__;" >> ${SEARCH_REGION_C_FILE_PATH}
	printf '%s\n' "void *start_address[4] = {&_sbss,&_sdata, &__bss_start__, 0};" >> ${SEARCH_REGION_C_FILE_PATH}
	printf '%s\n\n' "void *end_address[4] = {&_ebss,&_edata, &__bss_end__, 0};" >> ${SEARCH_REGION_C_FILE_PATH}
elif [[ "${CONFIG_ARCH_BOARD_RTL8721CSM}" == "y" ]]; then
	printf '%s\n%s\n%s\n%s\n\n' "extern uint32_t __psram_bss_start__;" "extern uint32_t __psram_bss_end__;" "extern uint32_t __psram_data_start__;" "extern uint32_t __psram_data_end__;" >> ${SEARCH_REGION_C_FILE_PATH}
	printf '%s\n' "void *start_address[4] = {&_sbss,&_sdata, &__psram_bss_start__, &__psram_data_start__};" >> ${SEARCH_REGION_C_FILE_PATH}
        printf '%s\n\n' "void *end_address[4] = {&_ebss,&_edata, &__psram_bss_end__, &__psram_data_end__};" >> ${SEARCH_REGION_C_FILE_PATH}
else
	printf '%s\n' "void *start_address[4] = {&_sbss,&_sdata, 0, 0};" >> ${SEARCH_REGION_C_FILE_PATH}
	printf '%s\n\n' "void *end_address[4] = {&_ebss,&_edata, 0, 0};" >> ${SEARCH_REGION_C_FILE_PATH}
fi
