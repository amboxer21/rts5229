# Driver for Realtek PCI-Express card reader
#
# Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.  
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.
#
# Author:
#   wwang (wei_wang@realsil.com.cn)
#   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
#
# Makefile for the PCI-Express Card Reader drivers.
#

TARGET_MODULE := rts5229

EXTRA_CFLAGS := -Idrivers/misc/cardreader 

obj-m += $(TARGET_MODULE).o

$(TARGET_MODULE)-objs := rtsx.o rtsx_chip.o rtsx_transport.o rtsx_scsi.o rtsx_card.o \
			 general.o sd.o ms.o

default:
	cp -f ./define.release ./define.h
	patch /usr/src/linux-5.0.0/include/linux/timekeeping32.h < `pwd`/timekeeping32.patch
	make -C /lib/modules/$(shell uname -r)/build/ KBUILD_EXTMOD=$(PWD) modules
install:
	insmod `pwd`/rts5229.ko
clean:
	rm -f *.o *.ko
	rm -f $(TARGET_MODULE).mod.c
