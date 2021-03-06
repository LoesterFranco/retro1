EESchema Schematic File Version 2
LIBS:6502Computer-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:6502
LIBS:6502Bootstrapper-cache
LIBS:barrel_jack
LIBS:dips-s
LIBS:propeller
LIBS:vga
LIBS:keyboard_parts
LIBS:addressdecoder
LIBS:6502Computer-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LED-RESCUE-6502Computer LED1
U 1 1 56D512BB
P 3470 2715
F 0 "LED1" H 3470 2815 50  0000 C CNN
F 1 "LED" H 3470 2615 50  0000 C CNN
F 2 "6502Library:WP1503CB_LED" H 3470 2715 60  0001 C CNN
F 3 "" H 3470 2715 60  0000 C CNN
	1    3470 2715
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 56D512BD
P 3470 3065
F 0 "R1" V 3550 3065 50  0000 C CNN
F 1 "330" V 3470 3065 50  0000 C CNN
F 2 "6502Library:Resistor_Horizontal_RM10mm" V 3400 3065 30  0001 C CNN
F 3 "" H 3470 3065 30  0000 C CNN
	1    3470 3065
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 56D512BE
P 3470 3390
F 0 "#PWR01" H 3470 3140 50  0001 C CNN
F 1 "GND" H 3470 3240 50  0000 C CNN
F 2 "" H 3470 3390 60  0000 C CNN
F 3 "" H 3470 3390 60  0000 C CNN
	1    3470 3390
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 56D512BF
P 1295 1545
F 0 "#PWR02" H 1295 1295 50  0001 C CNN
F 1 "GND" H 1295 1395 50  0000 C CNN
F 2 "" H 1295 1545 60  0000 C CNN
F 3 "" H 1295 1545 60  0000 C CNN
	1    1295 1545
	0    -1   -1   0   
$EndComp
$Comp
L BARREL_JACK_NEW J1
U 1 1 56D512C3
P 995 1445
F 0 "J1" H 995 1695 60  0000 C CNN
F 1 "BARREL_JACK" H 995 1245 60  0000 C CNN
F 2 "6502Library:Barrel_Jack_PJ002A" H 995 1445 60  0001 C CNN
F 3 "" H 995 1445 60  0000 C CNN
	1    995  1445
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 56D512C4
P 2295 1495
F 0 "C3" H 2320 1595 50  0000 L CNN
F 1 ".33uf" H 2320 1395 50  0000 L CNN
F 2 "6502Library:C_Disc_D6_P5" H 2333 1345 30  0001 C CNN
F 3 "" H 2295 1495 60  0000 C CNN
	1    2295 1495
	1    0    0    -1  
$EndComp
Wire Wire Line
	3470 2515 3470 2415
Wire Wire Line
	3470 3390 3470 3215
Text Notes 7270 5930 0    197  ~ 39
ADDRESS DECODING\n
Text Notes 1390 4280 0    197  ~ 39
POWER SUPPLY\n
$Comp
L AddressDecoderModule U4
U 1 1 56E51955
P 8450 3695
AR Path="/56E51955" Ref="U4"  Part="1" 
AR Path="/56D50E2C/56E51955" Ref="U4"  Part="1" 
F 0 "U4" H 8450 2445 60  0000 C CNN
F 1 "AddressDecoderModule" H 8480 4500 60  0000 C CNN
F 2 "6502Library:Address_Decoder_CPLD2" H 8450 3695 60  0001 C CNN
F 3 "" H 8450 3695 60  0000 C CNN
	1    8450 3695
	1    0    0    -1  
$EndComp
Wire Wire Line
	7835 2995 8000 2995
$Comp
L C_Small C10
U 1 1 56E51F5E
P 7835 2895
F 0 "C10" H 7845 2965 50  0000 L CNN
F 1 ".1uf" H 7680 2955 50  0000 L CNN
F 2 "6502Library:C_Disc_D3_P2.5" H 7835 2895 60  0001 C CNN
F 3 "" H 7835 2895 60  0000 C CNN
	1    7835 2895
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 56E5205A
P 7835 2795
F 0 "#PWR03" H 7835 2545 50  0001 C CNN
F 1 "GND" H 7835 2645 50  0000 C CNN
F 2 "" H 7835 2795 60  0000 C CNN
F 3 "" H 7835 2795 60  0000 C CNN
	1    7835 2795
	-1   0    0    1   
$EndComp
Wire Wire Line
	8950 4845 8900 4845
$Comp
L C_Small C11
U 1 1 56E524A7
P 8950 4945
F 0 "C11" H 8830 4995 50  0000 L CNN
F 1 ".1uf" H 8960 4865 50  0000 L CNN
F 2 "6502Library:C_Disc_D3_P2.5" H 8950 4945 60  0001 C CNN
F 3 "" H 8950 4945 60  0000 C CNN
	1    8950 4945
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 56E52605
P 8950 5045
F 0 "#PWR04" H 8950 4795 50  0001 C CNN
F 1 "GND" H 8950 4895 50  0000 C CNN
F 2 "" H 8950 5045 60  0000 C CNN
F 3 "" H 8950 5045 60  0000 C CNN
	1    8950 5045
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 56E52B32
P 8000 4845
F 0 "#PWR05" H 8000 4595 50  0001 C CNN
F 1 "GND" H 8000 4695 50  0000 C CNN
F 2 "" H 8000 4845 60  0000 C CNN
F 3 "" H 8000 4845 60  0000 C CNN
	1    8000 4845
	1    0    0    -1  
$EndComp
Text GLabel 8000 4545 0    60   Input ~ 0
PHI2
Text GLabel 8000 4445 0    60   Input ~ 0
RW
Text Label 7885 3145 0    60   ~ 0
A4
Text Label 7885 3245 0    60   ~ 0
A5
Text Label 7885 3345 0    60   ~ 0
A6
Text Label 7885 3445 0    60   ~ 0
A7
Text Label 7885 3545 0    60   ~ 0
A8
Text Label 7885 3645 0    60   ~ 0
A9
Text Label 7885 3745 0    60   ~ 0
A10
Text Label 7885 3945 0    60   ~ 0
A11
Text Label 7885 4045 0    60   ~ 0
A12
Text Label 7885 4145 0    60   ~ 0
A13
Text Label 7885 4245 0    60   ~ 0
A14
Text Label 7885 4345 0    60   ~ 0
A15
Wire Wire Line
	8000 4345 7885 4345
Wire Wire Line
	8000 4245 7885 4245
Wire Wire Line
	8000 4145 7885 4145
Wire Wire Line
	8000 4045 7885 4045
Wire Wire Line
	8000 3945 7885 3945
Wire Wire Line
	8000 3745 7885 3745
Wire Wire Line
	8000 3645 7885 3645
Wire Wire Line
	8000 3545 7885 3545
Wire Wire Line
	8000 3445 7885 3445
Wire Wire Line
	8000 3345 7885 3345
Wire Wire Line
	8000 3245 7885 3245
Wire Wire Line
	8000 3145 7885 3145
Entry Wire Line
	7785 3245 7885 3145
Entry Wire Line
	7785 3345 7885 3245
Entry Wire Line
	7785 3445 7885 3345
Entry Wire Line
	7785 3545 7885 3445
Entry Wire Line
	7785 3645 7885 3545
Entry Wire Line
	7785 3745 7885 3645
Entry Wire Line
	7785 3845 7885 3745
Wire Bus Line
	7595 3145 7785 3145
Wire Bus Line
	7785 3145 7785 4445
Entry Wire Line
	7785 4045 7885 3945
Entry Wire Line
	7785 4145 7885 4045
Entry Wire Line
	7785 4245 7885 4145
Entry Wire Line
	7785 4345 7885 4245
Entry Wire Line
	7785 4445 7885 4345
Text GLabel 8900 4745 2    60   Input ~ 0
CS_ACIA1
Text GLabel 8900 4645 2    60   Input ~ 0
CS_ACIA2
Text GLabel 8900 4545 2    60   Input ~ 0
CS_VIA1
Text GLabel 8900 4445 2    60   Input ~ 0
CS_VIA2
Text GLabel 8900 4345 2    60   Input ~ 0
CS_SID
Text GLabel 8900 4245 2    60   Input ~ 0
CS_RTC
Text GLabel 8900 3545 2    60   Input ~ 0
ROM_CE
Text GLabel 8900 3645 2    60   Input ~ 0
RAM_CE
Text GLabel 8000 4645 0    60   Input ~ 0
OE
Text GLabel 8900 3745 2    60   Input ~ 0
WE
Wire Wire Line
	8925 3395 8900 3395
Wire Wire Line
	8925 3295 8900 3295
Wire Wire Line
	8925 3195 8900 3195
Wire Wire Line
	8925 3095 8900 3095
Wire Wire Line
	8925 2995 8900 2995
$Comp
L CP1 C4
U 1 1 56E6E633
P 2575 1495
F 0 "C4" H 2600 1595 50  0000 L CNN
F 1 "47uf" H 2600 1395 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2" H 2575 1495 60  0001 C CNN
F 3 "" H 2575 1495 60  0000 C CNN
	1    2575 1495
	1    0    0    -1  
$EndComp
Wire Wire Line
	2295 1345 2690 1345
$Comp
L GND #PWR06
U 1 1 56E6E9B2
P 3090 1595
F 0 "#PWR06" H 3090 1345 50  0001 C CNN
F 1 "GND" H 3090 1445 50  0000 C CNN
F 2 "" H 3090 1595 60  0000 C CNN
F 3 "" H 3090 1595 60  0000 C CNN
	1    3090 1595
	1    0    0    -1  
$EndComp
Connection ~ 2575 1345
$Comp
L R R2
U 1 1 56E6FF2F
P 3765 1370
F 0 "R2" V 3845 1370 50  0000 C CNN
F 1 "422k" V 3765 1370 50  0000 C CNN
F 2 "6502Library:Resistor_Horizontal_RM10mm" V 3695 1370 30  0001 C CNN
F 3 "" H 3765 1370 30  0000 C CNN
	1    3765 1370
	1    0    0    -1  
$EndComp
Wire Wire Line
	3515 1220 4485 1220
Wire Wire Line
	3515 1370 3625 1370
Wire Wire Line
	3625 1370 3625 1540
$Comp
L R R3
U 1 1 56E70138
P 3765 1710
F 0 "R3" V 3845 1710 50  0000 C CNN
F 1 "53.6k" V 3765 1710 50  0000 C CNN
F 2 "6502Library:Resistor_Horizontal_RM10mm" V 3695 1710 30  0001 C CNN
F 3 "" H 3765 1710 30  0000 C CNN
	1    3765 1710
	1    0    0    -1  
$EndComp
Wire Wire Line
	3765 1520 3765 1560
Wire Wire Line
	3625 1540 3765 1540
Connection ~ 3765 1540
$Comp
L GND #PWR07
U 1 1 56E7084C
P 3765 1860
F 0 "#PWR07" H 3765 1610 50  0001 C CNN
F 1 "GND" H 3765 1710 50  0000 C CNN
F 2 "" H 3765 1860 60  0000 C CNN
F 3 "" H 3765 1860 60  0000 C CNN
	1    3765 1860
	1    0    0    -1  
$EndComp
$Comp
L CP1 C5
U 1 1 56E712A4
P 4025 1370
F 0 "C5" H 4050 1470 50  0000 L CNN
F 1 "1000uf" H 4050 1270 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D12.5_L25_P5" H 4025 1370 60  0001 C CNN
F 3 "" H 4025 1370 60  0000 C CNN
	1    4025 1370
	1    0    0    -1  
$EndComp
Connection ~ 3765 1220
$Comp
L C C6
U 1 1 56E71BA5
P 4340 1370
F 0 "C6" H 4365 1470 50  0000 L CNN
F 1 ".1uf" H 4365 1270 50  0000 L CNN
F 2 "6502Library:C_Disc_D3_P2.5" H 4378 1220 30  0001 C CNN
F 3 "" H 4340 1370 60  0000 C CNN
	1    4340 1370
	1    0    0    -1  
$EndComp
Connection ~ 4025 1220
$Comp
L GND #PWR08
U 1 1 56E71E9C
P 4025 1520
F 0 "#PWR08" H 4025 1270 50  0001 C CNN
F 1 "GND" H 4025 1370 50  0000 C CNN
F 2 "" H 4025 1520 60  0000 C CNN
F 3 "" H 4025 1520 60  0000 C CNN
	1    4025 1520
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 56E71F04
P 4340 1520
F 0 "#PWR09" H 4340 1270 50  0001 C CNN
F 1 "GND" H 4340 1370 50  0000 C CNN
F 2 "" H 4340 1520 60  0000 C CNN
F 3 "" H 4340 1520 60  0000 C CNN
	1    4340 1520
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR010
U 1 1 56E724E1
P 4485 1220
F 0 "#PWR010" H 4485 1070 50  0001 C CNN
F 1 "+12V" H 4485 1360 50  0000 C CNN
F 2 "" H 4485 1220 60  0000 C CNN
F 3 "" H 4485 1220 60  0000 C CNN
	1    4485 1220
	0    1    1    0   
$EndComp
Connection ~ 4340 1220
$Comp
L MIC29300-5.0WT U1
U 1 1 56E73B6A
P 1395 2440
F 0 "U1" H 1245 2315 60  0000 C CNN
F 1 "MIC29150-5.0WT" H 1395 2765 60  0000 C CNN
F 2 "mod_to:to220-horiz_5772" H 1395 2440 60  0001 C CNN
F 3 "" H 1395 2440 60  0000 C CNN
	1    1395 2440
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 56E74269
P 1395 2665
F 0 "#PWR011" H 1395 2415 50  0001 C CNN
F 1 "GND" H 1395 2515 50  0000 C CNN
F 2 "" H 1395 2665 60  0000 C CNN
F 3 "" H 1395 2665 60  0000 C CNN
	1    1395 2665
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR012
U 1 1 56E742BD
P 1020 2240
F 0 "#PWR012" H 1020 2090 50  0001 C CNN
F 1 "+12V" H 1020 2380 50  0000 C CNN
F 2 "" H 1020 2240 60  0000 C CNN
F 3 "" H 1020 2240 60  0000 C CNN
	1    1020 2240
	0    -1   -1   0   
$EndComp
$Comp
L CP1 C1
U 1 1 56E743F1
P 1835 2390
F 0 "C1" H 1860 2490 50  0000 L CNN
F 1 "1000uf" H 1860 2290 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D10_L16_P5" H 1835 2390 60  0001 C CNN
F 3 "" H 1835 2390 60  0000 C CNN
	1    1835 2390
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 56E745E0
P 2135 2390
F 0 "C2" H 2160 2490 50  0000 L CNN
F 1 ".1uf" H 2160 2290 50  0000 L CNN
F 2 "6502Library:C_Disc_D3_P2.5" H 2173 2240 30  0001 C CNN
F 3 "" H 2135 2390 60  0000 C CNN
	1    2135 2390
	1    0    0    -1  
$EndComp
Wire Wire Line
	1745 2240 2255 2240
Connection ~ 1835 2240
$Comp
L GND #PWR013
U 1 1 56E747AE
P 1835 2540
F 0 "#PWR013" H 1835 2290 50  0001 C CNN
F 1 "GND" H 1835 2390 50  0000 C CNN
F 2 "" H 1835 2540 60  0000 C CNN
F 3 "" H 1835 2540 60  0000 C CNN
	1    1835 2540
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR014
U 1 1 56E74806
P 2135 2540
F 0 "#PWR014" H 2135 2290 50  0001 C CNN
F 1 "GND" H 2135 2390 50  0000 C CNN
F 2 "" H 2135 2540 60  0000 C CNN
F 3 "" H 2135 2540 60  0000 C CNN
	1    2135 2540
	1    0    0    -1  
$EndComp
Connection ~ 2135 2240
$Comp
L MIC29300-5.0WT U3
U 1 1 56E7582A
P 4735 2540
F 0 "U3" H 4585 2415 60  0000 C CNN
F 1 "MIC29150-3.3WT" H 4735 2865 60  0000 C CNN
F 2 "mod_to:to220-horiz-notab" H 4735 2540 60  0001 C CNN
F 3 "" H 4735 2540 60  0000 C CNN
	1    4735 2540
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 56E75830
P 4735 2765
F 0 "#PWR015" H 4735 2515 50  0001 C CNN
F 1 "GND" H 4735 2615 50  0000 C CNN
F 2 "" H 4735 2765 60  0000 C CNN
F 3 "" H 4735 2765 60  0000 C CNN
	1    4735 2765
	1    0    0    -1  
$EndComp
$Comp
L CP1 C7
U 1 1 56E7583C
P 5175 2490
F 0 "C7" H 5200 2590 50  0000 L CNN
F 1 "47uf" H 5200 2390 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2" H 5175 2490 60  0001 C CNN
F 3 "" H 5175 2490 60  0000 C CNN
	1    5175 2490
	1    0    0    -1  
$EndComp
$Comp
L C C8
U 1 1 56E75842
P 5475 2490
F 0 "C8" H 5500 2590 50  0000 L CNN
F 1 ".1uf" H 5500 2390 50  0000 L CNN
F 2 "6502Library:C_Disc_D3_P2.5" H 5513 2340 30  0001 C CNN
F 3 "" H 5475 2490 60  0000 C CNN
	1    5475 2490
	1    0    0    -1  
$EndComp
Wire Wire Line
	5085 2340 5675 2340
Connection ~ 5175 2340
$Comp
L GND #PWR016
U 1 1 56E7584A
P 5175 2640
F 0 "#PWR016" H 5175 2390 50  0001 C CNN
F 1 "GND" H 5175 2490 50  0000 C CNN
F 2 "" H 5175 2640 60  0000 C CNN
F 3 "" H 5175 2640 60  0000 C CNN
	1    5175 2640
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 56E75850
P 5475 2640
F 0 "#PWR017" H 5475 2390 50  0001 C CNN
F 1 "GND" H 5475 2490 50  0000 C CNN
F 2 "" H 5475 2640 60  0000 C CNN
F 3 "" H 5475 2640 60  0000 C CNN
	1    5475 2640
	1    0    0    -1  
$EndComp
Connection ~ 5475 2340
$Comp
L C C9
U 1 1 56E75B8C
P 5675 2490
F 0 "C9" H 5700 2590 50  0000 L CNN
F 1 ".33uf" H 5700 2390 50  0000 L CNN
F 2 "6502Library:C_Disc_D6_P5" H 5713 2340 30  0001 C CNN
F 3 "" H 5675 2490 60  0000 C CNN
	1    5675 2490
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 56E75DA7
P 5675 2640
F 0 "#PWR018" H 5675 2390 50  0001 C CNN
F 1 "GND" H 5675 2490 50  0000 C CNN
F 2 "" H 5675 2640 60  0000 C CNN
F 3 "" H 5675 2640 60  0000 C CNN
	1    5675 2640
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR019
U 1 1 56E75E00
P 5805 2340
F 0 "#PWR019" H 5805 2190 50  0001 C CNN
F 1 "+3.3V" H 5805 2480 50  0000 C CNN
F 2 "" H 5805 2340 60  0000 C CNN
F 3 "" H 5805 2340 60  0000 C CNN
	1    5805 2340
	0    1    1    0   
$EndComp
Wire Wire Line
	5805 2340 5670 2340
Connection ~ 5670 2340
$Comp
L GND #PWR020
U 1 1 56E7C7E6
P 2575 1645
F 0 "#PWR020" H 2575 1395 50  0001 C CNN
F 1 "GND" H 2575 1495 50  0000 C CNN
F 2 "" H 2575 1645 60  0000 C CNN
F 3 "" H 2575 1645 60  0000 C CNN
	1    2575 1645
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 56E7C845
P 2295 1645
F 0 "#PWR021" H 2295 1395 50  0001 C CNN
F 1 "GND" H 2295 1495 50  0000 C CNN
F 2 "" H 2295 1645 60  0000 C CNN
F 3 "" H 2295 1645 60  0000 C CNN
	1    2295 1645
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR022
U 1 1 56E85787
P 2255 2240
F 0 "#PWR022" H 2255 2090 50  0001 C CNN
F 1 "+5V" H 2255 2380 50  0000 C CNN
F 2 "" H 2255 2240 60  0000 C CNN
F 3 "" H 2255 2240 60  0000 C CNN
	1    2255 2240
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR023
U 1 1 56E85868
P 3470 2415
F 0 "#PWR023" H 3470 2265 50  0001 C CNN
F 1 "+5V" H 3470 2555 50  0000 C CNN
F 2 "" H 3470 2415 60  0000 C CNN
F 3 "" H 3470 2415 60  0000 C CNN
	1    3470 2415
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR024
U 1 1 56E85AD7
P 4360 2340
F 0 "#PWR024" H 4360 2190 50  0001 C CNN
F 1 "+5V" H 4360 2480 50  0000 C CNN
F 2 "" H 4360 2340 60  0000 C CNN
F 3 "" H 4360 2340 60  0000 C CNN
	1    4360 2340
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR025
U 1 1 56E864C6
P 8950 4845
F 0 "#PWR025" H 8950 4695 50  0001 C CNN
F 1 "+5V" H 8950 4985 50  0000 C CNN
F 2 "" H 8950 4845 60  0000 C CNN
F 3 "" H 8950 4845 60  0000 C CNN
	1    8950 4845
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR026
U 1 1 56E86606
P 7835 2995
F 0 "#PWR026" H 7835 2845 50  0001 C CNN
F 1 "+5V" H 7835 3135 50  0000 C CNN
F 2 "" H 7835 2995 60  0000 C CNN
F 3 "" H 7835 2995 60  0000 C CNN
	1    7835 2995
	0    -1   -1   0   
$EndComp
$Comp
L MIC29302 U2
U 1 1 56E9A048
P 3265 1895
F 0 "U2" H 2910 2295 60  0000 C CNN
F 1 "MIC29152WT" H 3090 2660 60  0000 C CNN
F 2 "mod_to:to220-5-horiz-notab" H 3265 1895 60  0001 C CNN
F 3 "" H 3265 1895 60  0000 C CNN
	1    3265 1895
	1    0    0    -1  
$EndComp
Wire Wire Line
	2645 1220 2645 1345
Connection ~ 2645 1345
Text Notes 4220 1055 0    60   ~ 0
Approx 11 volts output
Text Notes 655  1120 0    60   ~ 0
12 volts input
Text Notes 7360 7510 0    60   ~ 0
POWER SUPPLY, ADDRESS DECODING
Text Notes 8185 7645 0    60   ~ 0
3/22/2016
Text Notes 10575 7640 0    60   ~ 0
1.A
Wire Wire Line
	2645 1220 2690 1220
$Comp
L DECODER_JUMPERS JP1
U 1 1 570B77B3
P 10245 2920
F 0 "JP1" H 10245 2445 60  0000 C CNN
F 1 "DECODER_JUMPERS" H 10245 3420 60  0000 C CNN
F 2 "6502Library:Pin_Header_Straight_3x05" H 10245 2920 60  0001 C CNN
F 3 "" H 10245 2920 60  0000 C CNN
	1    10245 2920
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 570B8CBE
P 9920 2545
F 0 "#PWR027" H 9920 2295 50  0001 C CNN
F 1 "GND" H 9920 2395 50  0000 C CNN
F 2 "" H 9920 2545 60  0000 C CNN
F 3 "" H 9920 2545 60  0000 C CNN
	1    9920 2545
	0    1    1    0   
$EndComp
$Comp
L GND #PWR028
U 1 1 570B8D20
P 9920 2720
F 0 "#PWR028" H 9920 2470 50  0001 C CNN
F 1 "GND" H 9920 2570 50  0000 C CNN
F 2 "" H 9920 2720 60  0000 C CNN
F 3 "" H 9920 2720 60  0000 C CNN
	1    9920 2720
	0    1    1    0   
$EndComp
$Comp
L GND #PWR029
U 1 1 570B8D82
P 9920 2895
F 0 "#PWR029" H 9920 2645 50  0001 C CNN
F 1 "GND" H 9920 2745 50  0000 C CNN
F 2 "" H 9920 2895 60  0000 C CNN
F 3 "" H 9920 2895 60  0000 C CNN
	1    9920 2895
	0    1    1    0   
$EndComp
$Comp
L GND #PWR030
U 1 1 570B8DE4
P 9920 3245
F 0 "#PWR030" H 9920 2995 50  0001 C CNN
F 1 "GND" H 9920 3095 50  0000 C CNN
F 2 "" H 9920 3245 60  0000 C CNN
F 3 "" H 9920 3245 60  0000 C CNN
	1    9920 3245
	0    1    1    0   
$EndComp
$Comp
L GND #PWR031
U 1 1 570B8E46
P 9920 3070
F 0 "#PWR031" H 9920 2820 50  0001 C CNN
F 1 "GND" H 9920 2920 50  0000 C CNN
F 2 "" H 9920 3070 60  0000 C CNN
F 3 "" H 9920 3070 60  0000 C CNN
	1    9920 3070
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR032
U 1 1 570B9A84
P 10370 2545
F 0 "#PWR032" H 10370 2395 50  0001 C CNN
F 1 "+5V" H 10370 2685 50  0000 C CNN
F 2 "" H 10370 2545 60  0000 C CNN
F 3 "" H 10370 2545 60  0000 C CNN
	1    10370 2545
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR033
U 1 1 570B9B5A
P 10370 2720
F 0 "#PWR033" H 10370 2570 50  0001 C CNN
F 1 "+5V" H 10370 2860 50  0000 C CNN
F 2 "" H 10370 2720 60  0000 C CNN
F 3 "" H 10370 2720 60  0000 C CNN
	1    10370 2720
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR034
U 1 1 570B9BF6
P 10370 2895
F 0 "#PWR034" H 10370 2745 50  0001 C CNN
F 1 "+5V" H 10370 3035 50  0000 C CNN
F 2 "" H 10370 2895 60  0000 C CNN
F 3 "" H 10370 2895 60  0000 C CNN
	1    10370 2895
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR035
U 1 1 570B9C58
P 10370 3070
F 0 "#PWR035" H 10370 2920 50  0001 C CNN
F 1 "+5V" H 10370 3210 50  0000 C CNN
F 2 "" H 10370 3070 60  0000 C CNN
F 3 "" H 10370 3070 60  0000 C CNN
	1    10370 3070
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR036
U 1 1 570B9CD7
P 10370 3245
F 0 "#PWR036" H 10370 3095 50  0001 C CNN
F 1 "+5V" H 10370 3385 50  0000 C CNN
F 2 "" H 10370 3245 60  0000 C CNN
F 3 "" H 10370 3245 60  0000 C CNN
	1    10370 3245
	0    1    1    0   
$EndComp
Wire Wire Line
	9995 2620 8915 2620
Wire Wire Line
	8915 2620 8915 2995
Connection ~ 8915 2995
Wire Wire Line
	8915 3095 9315 3095
Wire Wire Line
	9315 3095 9315 2795
Wire Wire Line
	9315 2795 9995 2795
Connection ~ 8915 3095
Wire Wire Line
	8910 3195 9450 3195
Wire Wire Line
	9450 3195 9450 2970
Wire Wire Line
	9450 2970 9995 2970
Connection ~ 8910 3195
Wire Wire Line
	8910 3295 9595 3295
Wire Wire Line
	9595 3295 9595 3145
Wire Wire Line
	9595 3145 9995 3145
Connection ~ 8910 3295
Wire Wire Line
	8910 3395 9995 3395
Wire Wire Line
	9995 3395 9995 3320
Connection ~ 8910 3395
Text HLabel 7215 3145 0    60   Input ~ 0
A[0..15]
Text Label 7260 3145 0    60   ~ 0
A[0..15]
Wire Bus Line
	7600 3145 7215 3145
$Comp
L SPST2 SW1
U 1 1 57142567
P 1795 1345
F 0 "SW1" H 1795 1445 50  0000 C CNN
F 1 "SPST2" H 1795 1245 50  0000 C CNN
F 2 "6502Library:SW_Micro_Right_Angle_SPST" H 1795 1345 50  0001 C CNN
F 3 "" H 1795 1345 50  0000 C CNN
	1    1795 1345
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X12 P16
U 1 1 5723B0F7
P 1950 3650
F 0 "P16" H 1950 4300 50  0000 C CNN
F 1 "CONN_01X12" V 2050 3650 50  0000 C CNN
F 2 "6502Library:Socket_Strip_Straight_1x12" H 1950 3650 50  0001 C CNN
F 3 "" H 1950 3650 50  0000 C CNN
	1    1950 3650
	0    1    1    0   
$EndComp
$Comp
L GND #PWR037
U 1 1 5723B6BA
P 1400 3450
F 0 "#PWR037" H 1400 3200 50  0001 C CNN
F 1 "GND" H 1400 3300 50  0000 C CNN
F 2 "" H 1400 3450 50  0000 C CNN
F 3 "" H 1400 3450 50  0000 C CNN
	1    1400 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR038
U 1 1 5723B77B
P 1500 3450
F 0 "#PWR038" H 1500 3200 50  0001 C CNN
F 1 "GND" H 1500 3300 50  0000 C CNN
F 2 "" H 1500 3450 50  0000 C CNN
F 3 "" H 1500 3450 50  0000 C CNN
	1    1500 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR039
U 1 1 5723B7D1
P 1600 3450
F 0 "#PWR039" H 1600 3200 50  0001 C CNN
F 1 "GND" H 1600 3300 50  0000 C CNN
F 2 "" H 1600 3450 50  0000 C CNN
F 3 "" H 1600 3450 50  0000 C CNN
	1    1600 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR040
U 1 1 5723B827
P 1700 3450
F 0 "#PWR040" H 1700 3200 50  0001 C CNN
F 1 "GND" H 1700 3300 50  0000 C CNN
F 2 "" H 1700 3450 50  0000 C CNN
F 3 "" H 1700 3450 50  0000 C CNN
	1    1700 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR041
U 1 1 5723B87D
P 1800 3450
F 0 "#PWR041" H 1800 3200 50  0001 C CNN
F 1 "GND" H 1800 3300 50  0000 C CNN
F 2 "" H 1800 3450 50  0000 C CNN
F 3 "" H 1800 3450 50  0000 C CNN
	1    1800 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR042
U 1 1 5723B8D3
P 1900 3450
F 0 "#PWR042" H 1900 3200 50  0001 C CNN
F 1 "GND" H 1900 3300 50  0000 C CNN
F 2 "" H 1900 3450 50  0000 C CNN
F 3 "" H 1900 3450 50  0000 C CNN
	1    1900 3450
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR043
U 1 1 5723B92B
P 2000 3450
F 0 "#PWR043" H 2000 3300 50  0001 C CNN
F 1 "+5V" H 2000 3590 50  0000 C CNN
F 2 "" H 2000 3450 50  0000 C CNN
F 3 "" H 2000 3450 50  0000 C CNN
	1    2000 3450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR044
U 1 1 5723B988
P 2100 3450
F 0 "#PWR044" H 2100 3300 50  0001 C CNN
F 1 "+5V" H 2100 3590 50  0000 C CNN
F 2 "" H 2100 3450 50  0000 C CNN
F 3 "" H 2100 3450 50  0000 C CNN
	1    2100 3450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR045
U 1 1 5723B9DE
P 2200 3450
F 0 "#PWR045" H 2200 3300 50  0001 C CNN
F 1 "+5V" H 2200 3590 50  0000 C CNN
F 2 "" H 2200 3450 50  0000 C CNN
F 3 "" H 2200 3450 50  0000 C CNN
	1    2200 3450
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR046
U 1 1 5723BA1D
P 2300 3450
F 0 "#PWR046" H 2300 3300 50  0001 C CNN
F 1 "+3.3V" H 2300 3590 50  0000 C CNN
F 2 "" H 2300 3450 50  0000 C CNN
F 3 "" H 2300 3450 50  0000 C CNN
	1    2300 3450
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR047
U 1 1 5723BA7A
P 2400 3450
F 0 "#PWR047" H 2400 3300 50  0001 C CNN
F 1 "+3.3V" H 2400 3590 50  0000 C CNN
F 2 "" H 2400 3450 50  0000 C CNN
F 3 "" H 2400 3450 50  0000 C CNN
	1    2400 3450
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR048
U 1 1 5723BAD0
P 2500 3450
F 0 "#PWR048" H 2500 3300 50  0001 C CNN
F 1 "+3.3V" H 2500 3590 50  0000 C CNN
F 2 "" H 2500 3450 50  0000 C CNN
F 3 "" H 2500 3450 50  0000 C CNN
	1    2500 3450
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X07 P1
U 1 1 57296FE0
P 9125 3095
F 0 "P1" H 9125 3495 50  0000 C CNN
F 1 "CONN_01X07" V 9225 3095 50  0000 C CNN
F 2 "6502Library:Socket_Strip_Straight_1x07" H 9125 3095 50  0001 C CNN
F 3 "" H 9125 3095 50  0000 C CNN
	1    9125 3095
	1    0    0    -1  
$EndComp
Text GLabel 8740 2770 0    60   Input ~ 0
CS8
Wire Wire Line
	8740 2770 8805 2770
Wire Wire Line
	8805 2770 8805 2895
Wire Wire Line
	8805 2895 8925 2895
Text GLabel 8740 2640 0    60   Input ~ 0
CS7
Wire Wire Line
	8740 2640 8835 2640
Wire Wire Line
	8835 2640 8835 2795
Wire Wire Line
	8835 2795 8925 2795
Text GLabel 8900 4045 2    60   Input ~ 0
CS8
Text GLabel 8900 4145 2    60   Input ~ 0
CS7
$EndSCHEMATC
