OSTOOLDIR=`test -d ${0%/*} && cd ${0%/*}; pwd`
OSDIR="${OSTOOLDIR}/.."
SEARCH_REGION_C_FILE_PATH=${OSDIR}/kernel/debug/newfile.c

echo 'starting the file creation'
printf '%s\n' "/* Automatically generated file; DO NOT EDIT. */">${SEARCH_REGION_C_FILE_PATH}
printf '%s\n' "#include <tinyara/config.h>" >> ${SEARCH_REGION_C_FILE_PATH}
printf '%s\n\n' "#include <sys/types.h>" >> ${SEARCH_REGION_C_FILE_PATH}


printf '%s\n%s\n\n' "extern uint32_t _sbss;" "extern uint32_t _ebss;" >> ${SEARCH_REGION_C_FILE_PATH}

printf '%s\n%s\n\n' "extern uint32_t _sdata;" "extern uint32_t _edata;" >> ${SEARCH_REGION_C_FILE_PATH}


#printf '%s\n%s\n\n' "uint32_t start_address[4] = {_sbss,_sdata};" "uint32_t end_address[4] = {_ebss,_sdata};" >> ${SEARCH_REGION_C_FILE_PATH}

printf '%s\n%s\n\n' "void *start_address[4] = {&_sbss,&_sdata};" "void *end_address[4] = {&_ebss, &_sdata};" >> ${SEARCH_REGION_C_FILE_PATH}


printf '%s\n%s\n%s\n%s\n%s\n%s\n\n' "#ifdef CONFIG_ARCH_BOARD_RTL8720E" "extern uint32_t __bss_start__;" "extern uint32_t __bss_end__;" "start_address[2] = &__bss_start__;" "end_address[2] = &__bss_end__;" "#endif" >> ${SEARCH_REGION_C_FILE_PATH}

#------------no & ---
#printf '%s\n%s\n%s\n%s\n%s\n%s\n\n' "#ifdef CONFIG_ARCH_BOARD_RTL8720E" "extern uint32_t __bss_start__;" "extern uint32_t __bss_end__;" "start_address[2] = __bss_start__;" "end_address[2] = __bss_end__;" "#endif" >> ${SEARCH_REGION_C_FILE_PATH}



printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n' "#ifdef CONFIG_ARCH_BOARD_RTL8721CSM" "extern uint32_t __psram_bss_start__;" "extern uint32_t __psram_bss_end__;" "extern uint32_t __psram_data_start__;" "extern uint32_t __psram_data_end__;" "start_address[2] = &__psram_bss_start__;" "end_address[2] = &__psram_bss_end__;" "start_address[3] = &__psram_data_start__;" "end_address[3] = &__psram_data_end__;"  "#endif" >> ${SEARCH_REGION_C_FILE_PATH}


#------------no &--------


#printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n' "#ifdef CONFIG_ARCH_BOARD_RTL8721CSM" "extern uint32_t __psram_bss_start__;" "extern uint32_t __psram_bss_end__;" "extern uint32_t __psram_data_start__;" "extern uint32_t __psram_data_end__;" "start_address[2] = __psram_bss_start__;" "end_address[2] = __psram_bss_end__;" "start_address[3] = __psram_data_start__;" "end_address[3] = __psram_data_end__;"  "#endif" >> ${SEARCH_REGION_C_FILE_PATH}

