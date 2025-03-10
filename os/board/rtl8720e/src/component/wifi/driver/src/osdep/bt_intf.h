/******************************************************************************
 * Copyright (c) 2013-2016 Realtek Semiconductor Corp.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
#ifndef __BT_INTF_H__
#define __BT_INTF_H__

#ifdef	__cplusplus
extern "C" {
#endif
#include <autoconf.h>



typedef enum pta_type {
	PTA_AUTO                 = 0,
	PTA_WIFI			= 1,
	PTA_BT				= 2
} pta_type_t;

typedef enum bt_rfk_type {
	BT_RX_DCK       = 0,
	BT_LOK             = 1,
	BT_LOK_RES      = 2,
	BT_DAC_DCK     = 3
} bt_rfk_type_t;

struct bt_rfk_param {
	bt_rfk_type_t type;
	uint8_t  rfk_data1;
	uint8_t  rfk_data2;
	uint8_t  rfk_data3;
	uint8_t  rfk_data4;
};


//----- ------------------------------------------------------------------
// BT Interface opened for upper layer
//----- ------------------------------------------------------------------
void rltk_bt_set_gnt_bt(pta_type_t  gnt_bt);
void rltk_bt_set_gnt_bt_with_clk_source(pta_type_t gnt_bt);
const unsigned char *rltk_bt_get_patch_code(void);
unsigned int rltk_bt_get_patch_code_len(void);
void rltk_bt_pta_init(void);
void rltk_coex_bt_enable(u8 enable);
int rltk_coex_mailbox_to_wifi(u8 *data, u8 len);
int rltk_coex_bt_rfk(struct bt_rfk_param *rfk_param);

#ifdef	__cplusplus
}
#endif

#endif //#ifndef __BT_INTF_H__
