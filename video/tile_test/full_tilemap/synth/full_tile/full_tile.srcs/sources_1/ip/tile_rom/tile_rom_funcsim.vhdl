-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
-- Date        : Tue Oct 27 17:02:10 2015
-- Host        : ahtanum.andrew.cmu.edu running 64-bit Red Hat Enterprise Linux Server release 7.1 (Maipo)
-- Command     : write_vhdl -force -mode funcsim
--               /afs/ece.cmu.edu/usr/rohitban/Private/545/video/tilemap/full_tilemap/synth/full_tile/full_tile.srcs/sources_1/ip/tile_rom/tile_rom_funcsim.vhdl
-- Design      : tile_rom
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom_blk_mem_gen_prim_wrapper_init is
  port (
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tile_rom_blk_mem_gen_prim_wrapper_init : entity is "blk_mem_gen_prim_wrapper_init";
end tile_rom_blk_mem_gen_prim_wrapper_init;

architecture STRUCTURE of tile_rom_blk_mem_gen_prim_wrapper_init is
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
begin
\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"000000227777000000001111FFFF1111001133444466331100CCEE331111EECC",
      INIT_01 => X"0000444455776644002233999999FF660022664444557733003377FFDDDD9911",
      INIT_02 => X"0077775555555500002233111111FFEE000011336677770000CCCC4444FFFF44",
      INIT_03 => X"006666444455776600000077FF880000001133664444440000EEFF999999FF66",
      INIT_04 => X"00337744444477330000999999BBEECC003377554444330000669999DDDD7766",
      INIT_05 => X"007777444444773300FFFF999999FF66001133664466331100FFFF444444FFFF",
      INIT_06 => X"007777444466331100FFFF111133EECC001133664444662200CCEE3311113322",
      INIT_07 => X"007777444444444400FFFF888888880000007777444444440000FFFF99999911",
      INIT_08 => X"0000000101000000000000080800000000000001010000000000000808000000",
      INIT_09 => X"00000103030100000000080C0C08000000000103030100000000080C0C080000",
      INIT_0A => X"03070F0F0F0F07030C0E0F0F0F0F0E0C03070F0F0F0F07030C0E0F0F0F0F0E0C",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"00000000113333330000008888CCCCEE3333110000000000EEFFFFFF77000000",
      INIT_11 => X"00000022337777FF0000000000888888FFFFFFEECC0000008888000000000000",
      INIT_12 => X"0000000000000000006666000000000000000000000000000000000000000000",
      INIT_13 => X"0000DDEE00DDEE0000000000000000000000DDEE00DDEE000000000000000000",
      INIT_14 => X"000011DDDDDDDDDD0000FFFFBBBBBBBBFFFFCCCCCCCCFF77FFFF00000000FFFF",
      INIT_15 => X"FFFFCCCCFF770000FFFF0000FFFF0000FF770000FFFFCCCCFFFF0000FFFF0000",
      INIT_16 => X"000077FFCCCCCCCC0000EEFF3333333377FFCCCCCCCCCCCCEEFF333333333333",
      INIT_17 => X"00000000000000000000000000000000FF77000000000000FFEE000000000000",
      INIT_18 => X"00000044FFFF000000002222EEEE22220033778888CC77330088CC662222CC88",
      INIT_19 => X"00008899BBFFDD88004466222222EECC0044CC9999BBFF660066EEEEAAAA2222",
      INIT_1A => X"00EEEEAAAAAABB11004466222222EECC00113366CCFFFF000088888888EEEE88",
      INIT_1B => X"00CCCC8899BBEECC000000EEEE000000003377DD9999990000CCEE222222EECC",
      INIT_1C => X"0066FF999999FF77000022222266CC880066FFBB9999660000CC2222AAAAEECC",
      INIT_1D => X"0000001111110000000000000000000000000000112244880022448800000000",
      INIT_1E => X"00000000000000FF11111111111111FF88888888888888FF00000000000000FF",
      INIT_1F => X"FF00000000000000FF11111111111111FF88888888888888FF00000000000000",
      INIT_20 => X"003377CC88CC773300EEEE888888EEEE00000000000000000000000000000000",
      INIT_21 => X"003377CC8888CC440088CC662222664400FFFF999999FF6600EEEE222222EECC",
      INIT_22 => X"0000FFFF999999880000EEEE2222222200FFFF8888CC773300EEEE222266CC88",
      INIT_23 => X"003377CC889999990088CC662222EEEE00FFFF999999998800EEEE0000000000",
      INIT_24 => X"00008888FFFF888800002222EEEE222200FFFF111111FFFF00EEEE000000EEEE",
      INIT_25 => X"00FFFF113366CC8800EEEE88CCEE6622000000000000FFFF004466222222EECC",
      INIT_26 => X"00FFFF773377FFFF00EEEE008800EEEE0000FFFF000000000000EEEE22222222",
      INIT_27 => X"0077FF888888FF7700CCEE222222EECC00FFFF773311FFFF00EEEE0088CCEEEE",
      INIT_28 => X"0077FF888888FF7700CCEE22AAEECCAA00FFFF888888FF7700EEEE8888888800",
      INIT_29 => X"0066FF9999DD5500004466222222EECC00FFFF888899FF7700EEEE88CCEE6622",
      INIT_2A => X"00FFFF000000FFFF00CCEE222222EECC00008888FFFF888800000000EEEE0000",
      INIT_2B => X"00FFFF113311FFFF00EEEECC88CCEEEE00FFFF110011FFFF000088CCEECC8800",
      INIT_2C => X"0000EEFF1111FFEE00000000EEEE000000CCEE773377EECC0066EECC88CCEE66",
      INIT_2D => X"00000033FFEECC00000022880000000000888899BBFFEECC0066EEEEAA222222",
      INIT_2E => X"3322222211002222EE88888800000000334499AAAA884433CC229955551122CC",
      INIT_2F => X"220000000000000044000000000000003322220011222222EE00000022AAAAAA",
      INIT_30 => X"000000000000000E000000000000000000000000000000000000000000000001",
      INIT_31 => X"00EEEEEEEEEEEEEE0000000000000000003333333300000000FFFFFFFFFF7733",
      INIT_32 => X"EEEEEEEEEEEEEEEE00000000000000003333110000000000FFFFFFFF77773333",
      INIT_33 => X"0000000000EEEEEE000000000000000000000000003333330000000000FFFFFF",
      INIT_34 => X"EEEEEEEEEEEEEEEE00000000000000000000000000000000FF77773333333333",
      INIT_35 => X"000000EEEEEEEEEE00000000000000000000003333333311000000FFFFFFFFFF",
      INIT_36 => X"00222266EEEEEECE000000000000000000000000000000000000000000001133",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"000044FF00007788000022EE2200CC2200000000000000000000000000000000",
      INIT_41 => X"EEAAAAAA9900778844222222CC00CC228888AADD8800778844222222CC00CC22",
      INIT_42 => X"887700778888770022CC00CC2222CC00CC8888BBCC0077880000EE000000CC22",
      INIT_43 => X"0000000000006688000000000000226644FF00007788887722EE2200CC2222CC",
      INIT_44 => X"000000000000888800000000000044228899660077888877AA222200CC2222CC",
      INIT_45 => X"000000000000EEAA0000000000004422AADD8800778888772222CC00CC2222CC",
      INIT_46 => X"007788887700778800CC2222CC00CC22AAAA9900778888772222CC00CC2222CC",
      INIT_47 => X"00000000000000000000000000000000887700000000000022CC000000000000",
      INIT_48 => X"000000000000000000000103031221410000101030300000809020C000000000",
      INIT_49 => X"00000E4F2F0F080700000000000000081FC30F0F070000000C8C0C0C08000000",
      INIT_4A => X"00000000101010330000072F0F9787D3101010000000000087A70F4F07000000",
      INIT_4B => X"0000080E4F0F1F4F000000000008080C0F1F8E0E080000000808000000000000",
      INIT_4C => X"000000000000001100000103070747EF10303010100000004787878703010000",
      INIT_4D => X"00000E0F0F0F0F0F00000008080C0C0C0F0F0F0F0F0E00000C0C0C0808000000",
      INIT_4E => X"0000000000010102000000010F0C0B0F02010100000000000F0F0F0F01000000",
      INIT_4F => X"0000030F0C070F0F00000C68686868680F0F0F0F0F0300006E6E6868680C0000",
      INIT_50 => X"000000010101001000000F0F0F0F0F8720010101000000000F0F0F0F0F070000",
      INIT_51 => X"00000C0F0F0F0F0F00000000080C0C080F0F2FCF0F0C00000C0C0C0800000000",
      INIT_52 => X"000000000004020200000000305263D20302020000000000BCF1615230000000",
      INIT_53 => X"000000E0BE5AE1F50000000080C08468A55BE17CB4E00000E0C2844880000000",
      INIT_54 => X"000000000000001000000F333171F3F00000000000000000F37131330F000000",
      INIT_55 => X"0000080C8ECF88FF00000000000000CC88CF8E0C080000000000000000000000",
      INIT_56 => X"000000001010202000000000E0E0F1E02010100000000000F1E0E00000000000",
      INIT_57 => X"000000000000FF00000000000000CC22DD88000000000000CC88000000000000",
      INIT_58 => X"0000000000000000FFFF7767231100000000000000000000000011337767EFFF",
      INIT_59 => X"FFFF1F0F69793300FFFFFFFFFFFFFF000033FFFF1F0F697900FFFFFFFFFFFFFF",
      INIT_5A => X"00CCCC880088CC00000000000000000000CC880088CCCC000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000606060606060606000000000000000006060606060606060",
      INIT_68 => X"00337474F8F9F9F9FFF0F0F788000000F9F9F9F87474330000000088F7F0F0FF",
      INIT_69 => X"FFF0F0FF00000000FFF0F0FF0000000000000000FFF0F0FF00000000FFF0F0FF",
      INIT_6A => X"FFF0F0FE1100000000CCE2E2F1F9F9F900000011FEF0F0FFF9F9F9F1E2E2CC00",
      INIT_6B => X"FFF0F0FE11000000FFF0F0F0F0F8F8F800000011FEF0F0FFF8F8F8F0F0F0F0FF",
      INIT_6C => X"FFF0F0F0F0F1F1F1FFF0F0F788000000F1F1F1F0F0F0F0FF00000088F7F0F0FF",
      INIT_6D => X"F9F9F9F9F9F9F9F90000000000000000F9F9F9F9F9F9F9F90000000000000000",
      INIT_6E => X"0000000000000000F9F9F9F9F9F9F9F90000000000000000F9F9F9F9F9F9F9F9",
      INIT_6F => X"0000000000000000F8F8F8F8F8F8F8F80000000000000000F8F8F8F8F8F8F8F8",
      INIT_70 => X"00CCE2E2F1F1F1F10000000000000000F1F1F1F1E2E2CC000000000000000000",
      INIT_71 => X"000000000000000000337474F8F8F8F80000000000000000F8F8F8F874743300",
      INIT_72 => X"F1F1F1F1F1F1F1F10000000000000000F1F1F1F1F1F1F1F10000000000000000",
      INIT_73 => X"0000000000000000000000003374F8F80000000000000000F8F8743300000000",
      INIT_74 => X"00000000FFF0F0F000000000FFF0F0F0F0F0F0FF00000000F0F0F0FF00000000",
      INIT_75 => X"00000000CCE2F1F10000000000000000F1F1E2CC000000000000000000000000",
      INIT_76 => X"000000000000000000000000FFF8F8F90000000000000000F9F8F8FF00000000",
      INIT_77 => X"00000000FFF1F1F90000000000000000F9F1F1FF000000000000000000000000",
      INIT_78 => X"0000000000000000F9F9F9F9F9F9F9FF0000000000000000FFF9F9F9F9F9F9F9",
      INIT_79 => X"F1F1F1F0F0F0F0F000000088F7F0F0F0F0F0F0F0F0F1F1F1F0F0F0F788000000",
      INIT_7A => X"00000011FEF0F0F0F8F8F8F0F0F0F0F0F0F0F0FE11000000F0F0F0F0F0F8F8F8",
      INIT_7B => X"0000000000000000000000003374F8F80000000000000000F8F8743300000000",
      INIT_7C => X"00000000CCE2F1F10000000000000000F1F1E2CC000000000000000000000000",
      INIT_7D => X"F9F9F9F8F8F8F8F800000088F7F0F0F0F8F8F8F8F8F9F9F9F0F0F0F788000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "PERFORMANCE",
      READ_WIDTH_A => 9,
      READ_WIDTH_B => 9,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 9,
      WRITE_WIDTH_B => 9
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 3) => addra(11 downto 0),
      ADDRARDADDR(2) => '1',
      ADDRARDADDR(1) => '1',
      ADDRARDADDR(0) => '1',
      ADDRBWRADDR(15) => '0',
      ADDRBWRADDR(14) => '0',
      ADDRBWRADDR(13) => '0',
      ADDRBWRADDR(12) => '0',
      ADDRBWRADDR(11) => '0',
      ADDRBWRADDR(10) => '0',
      ADDRBWRADDR(9) => '0',
      ADDRBWRADDR(8) => '0',
      ADDRBWRADDR(7) => '0',
      ADDRBWRADDR(6) => '0',
      ADDRBWRADDR(5) => '0',
      ADDRBWRADDR(4) => '0',
      ADDRBWRADDR(3) => '0',
      ADDRBWRADDR(2) => '0',
      ADDRBWRADDR(1) => '0',
      ADDRBWRADDR(0) => '0',
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31) => '0',
      DIADI(30) => '0',
      DIADI(29) => '0',
      DIADI(28) => '0',
      DIADI(27) => '0',
      DIADI(26) => '0',
      DIADI(25) => '0',
      DIADI(24) => '0',
      DIADI(23) => '0',
      DIADI(22) => '0',
      DIADI(21) => '0',
      DIADI(20) => '0',
      DIADI(19) => '0',
      DIADI(18) => '0',
      DIADI(17) => '0',
      DIADI(16) => '0',
      DIADI(15) => '0',
      DIADI(14) => '0',
      DIADI(13) => '0',
      DIADI(12) => '0',
      DIADI(11) => '0',
      DIADI(10) => '0',
      DIADI(9) => '0',
      DIADI(8) => '0',
      DIADI(7) => '0',
      DIADI(6) => '0',
      DIADI(5) => '0',
      DIADI(4) => '0',
      DIADI(3) => '0',
      DIADI(2) => '0',
      DIADI(1) => '0',
      DIADI(0) => '0',
      DIBDI(31) => '0',
      DIBDI(30) => '0',
      DIBDI(29) => '0',
      DIBDI(28) => '0',
      DIBDI(27) => '0',
      DIBDI(26) => '0',
      DIBDI(25) => '0',
      DIBDI(24) => '0',
      DIBDI(23) => '0',
      DIBDI(22) => '0',
      DIBDI(21) => '0',
      DIBDI(20) => '0',
      DIBDI(19) => '0',
      DIBDI(18) => '0',
      DIBDI(17) => '0',
      DIBDI(16) => '0',
      DIBDI(15) => '0',
      DIBDI(14) => '0',
      DIBDI(13) => '0',
      DIBDI(12) => '0',
      DIBDI(11) => '0',
      DIBDI(10) => '0',
      DIBDI(9) => '0',
      DIBDI(8) => '0',
      DIBDI(7) => '0',
      DIBDI(6) => '0',
      DIBDI(5) => '0',
      DIBDI(4) => '0',
      DIBDI(3) => '0',
      DIBDI(2) => '0',
      DIBDI(1) => '0',
      DIBDI(0) => '0',
      DIPADIP(3) => '0',
      DIPADIP(2) => '0',
      DIPADIP(1) => '0',
      DIPADIP(0) => '0',
      DIPBDIP(3) => '0',
      DIPBDIP(2) => '0',
      DIPBDIP(1) => '0',
      DIPBDIP(0) => '0',
      DOADO(31 downto 8) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\(31 downto 8),
      DOADO(7 downto 0) => douta(7 downto 0),
      DOBDO(31 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\(31 downto 0),
      DOPADOP(3 downto 1) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\(3 downto 1),
      DOPADOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71\,
      DOPBDOP(3 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\(3 downto 0),
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => '1',
      ENBWREN => '0',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3) => '0',
      WEA(2) => '0',
      WEA(1) => '0',
      WEA(0) => '0',
      WEBWE(7) => '0',
      WEBWE(6) => '0',
      WEBWE(5) => '0',
      WEBWE(4) => '0',
      WEBWE(3) => '0',
      WEBWE(2) => '0',
      WEBWE(1) => '0',
      WEBWE(0) => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom_blk_mem_gen_prim_width is
  port (
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tile_rom_blk_mem_gen_prim_width : entity is "blk_mem_gen_prim_width";
end tile_rom_blk_mem_gen_prim_width;

architecture STRUCTURE of tile_rom_blk_mem_gen_prim_width is
begin
\prim_init.ram\: entity work.tile_rom_blk_mem_gen_prim_wrapper_init
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      clka => clka,
      douta(7 downto 0) => douta(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom_blk_mem_gen_generic_cstr is
  port (
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tile_rom_blk_mem_gen_generic_cstr : entity is "blk_mem_gen_generic_cstr";
end tile_rom_blk_mem_gen_generic_cstr;

architecture STRUCTURE of tile_rom_blk_mem_gen_generic_cstr is
begin
\ramloop[0].ram.r\: entity work.tile_rom_blk_mem_gen_prim_width
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      clka => clka,
      douta(7 downto 0) => douta(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom_blk_mem_gen_top is
  port (
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tile_rom_blk_mem_gen_top : entity is "blk_mem_gen_top";
end tile_rom_blk_mem_gen_top;

architecture STRUCTURE of tile_rom_blk_mem_gen_top is
begin
\valid.cstr\: entity work.tile_rom_blk_mem_gen_generic_cstr
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      clka => clka,
      douta(7 downto 0) => douta(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom_blk_mem_gen_v8_2_synth is
  port (
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tile_rom_blk_mem_gen_v8_2_synth : entity is "blk_mem_gen_v8_2_synth";
end tile_rom_blk_mem_gen_v8_2_synth;

architecture STRUCTURE of tile_rom_blk_mem_gen_v8_2_synth is
begin
\gnativebmg.native_blk_mem_gen\: entity work.tile_rom_blk_mem_gen_top
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      clka => clka,
      douta(7 downto 0) => douta(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom_blk_mem_gen_v8_2 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    regcea : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 7 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    regceb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    injectsbiterr : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    eccpipece : in STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sleep : in STD_LOGIC;
    deepsleep : in STD_LOGIC;
    shutdown : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_injectsbiterr : in STD_LOGIC;
    s_axi_injectdbiterr : in STD_LOGIC;
    s_axi_sbiterr : out STD_LOGIC;
    s_axi_dbiterr : out STD_LOGIC;
    s_axi_rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of tile_rom_blk_mem_gen_v8_2 : entity is 12;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of tile_rom_blk_mem_gen_v8_2 : entity is 12;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of tile_rom_blk_mem_gen_v8_2 : entity is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of tile_rom_blk_mem_gen_v8_2 : entity is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of tile_rom_blk_mem_gen_v8_2 : entity is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of tile_rom_blk_mem_gen_v8_2 : entity is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of tile_rom_blk_mem_gen_v8_2 : entity is "0";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of tile_rom_blk_mem_gen_v8_2 : entity is "1";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of tile_rom_blk_mem_gen_v8_2 : entity is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of tile_rom_blk_mem_gen_v8_2 : entity is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of tile_rom_blk_mem_gen_v8_2 : entity is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of tile_rom_blk_mem_gen_v8_2 : entity is "Estimated Power for IP     :     2.326399 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of tile_rom_blk_mem_gen_v8_2 : entity is "artix7";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of tile_rom_blk_mem_gen_v8_2 : entity is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of tile_rom_blk_mem_gen_v8_2 : entity is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of tile_rom_blk_mem_gen_v8_2 : entity is "tile_rom.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of tile_rom_blk_mem_gen_v8_2 : entity is "tile_rom.mif";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of tile_rom_blk_mem_gen_v8_2 : entity is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of tile_rom_blk_mem_gen_v8_2 : entity is 3;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of tile_rom_blk_mem_gen_v8_2 : entity is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of tile_rom_blk_mem_gen_v8_2 : entity is 4096;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of tile_rom_blk_mem_gen_v8_2 : entity is 4096;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of tile_rom_blk_mem_gen_v8_2 : entity is 8;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of tile_rom_blk_mem_gen_v8_2 : entity is 8;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of tile_rom_blk_mem_gen_v8_2 : entity is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of tile_rom_blk_mem_gen_v8_2 : entity is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of tile_rom_blk_mem_gen_v8_2 : entity is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of tile_rom_blk_mem_gen_v8_2 : entity is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of tile_rom_blk_mem_gen_v8_2 : entity is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of tile_rom_blk_mem_gen_v8_2 : entity is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of tile_rom_blk_mem_gen_v8_2 : entity is 4096;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of tile_rom_blk_mem_gen_v8_2 : entity is 4096;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of tile_rom_blk_mem_gen_v8_2 : entity is "WRITE_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of tile_rom_blk_mem_gen_v8_2 : entity is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of tile_rom_blk_mem_gen_v8_2 : entity is 8;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of tile_rom_blk_mem_gen_v8_2 : entity is 8;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of tile_rom_blk_mem_gen_v8_2 : entity is "artix7";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tile_rom_blk_mem_gen_v8_2 : entity is "blk_mem_gen_v8_2";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of tile_rom_blk_mem_gen_v8_2 : entity is "yes";
end tile_rom_blk_mem_gen_v8_2;

architecture STRUCTURE of tile_rom_blk_mem_gen_v8_2 is
  signal \<const0>\ : STD_LOGIC;
begin
  dbiterr <= \<const0>\;
  doutb(7) <= \<const0>\;
  doutb(6) <= \<const0>\;
  doutb(5) <= \<const0>\;
  doutb(4) <= \<const0>\;
  doutb(3) <= \<const0>\;
  doutb(2) <= \<const0>\;
  doutb(1) <= \<const0>\;
  doutb(0) <= \<const0>\;
  rdaddrecc(11) <= \<const0>\;
  rdaddrecc(10) <= \<const0>\;
  rdaddrecc(9) <= \<const0>\;
  rdaddrecc(8) <= \<const0>\;
  rdaddrecc(7) <= \<const0>\;
  rdaddrecc(6) <= \<const0>\;
  rdaddrecc(5) <= \<const0>\;
  rdaddrecc(4) <= \<const0>\;
  rdaddrecc(3) <= \<const0>\;
  rdaddrecc(2) <= \<const0>\;
  rdaddrecc(1) <= \<const0>\;
  rdaddrecc(0) <= \<const0>\;
  s_axi_arready <= \<const0>\;
  s_axi_awready <= \<const0>\;
  s_axi_bid(3) <= \<const0>\;
  s_axi_bid(2) <= \<const0>\;
  s_axi_bid(1) <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_bvalid <= \<const0>\;
  s_axi_dbiterr <= \<const0>\;
  s_axi_rdaddrecc(11) <= \<const0>\;
  s_axi_rdaddrecc(10) <= \<const0>\;
  s_axi_rdaddrecc(9) <= \<const0>\;
  s_axi_rdaddrecc(8) <= \<const0>\;
  s_axi_rdaddrecc(7) <= \<const0>\;
  s_axi_rdaddrecc(6) <= \<const0>\;
  s_axi_rdaddrecc(5) <= \<const0>\;
  s_axi_rdaddrecc(4) <= \<const0>\;
  s_axi_rdaddrecc(3) <= \<const0>\;
  s_axi_rdaddrecc(2) <= \<const0>\;
  s_axi_rdaddrecc(1) <= \<const0>\;
  s_axi_rdaddrecc(0) <= \<const0>\;
  s_axi_rdata(7) <= \<const0>\;
  s_axi_rdata(6) <= \<const0>\;
  s_axi_rdata(5) <= \<const0>\;
  s_axi_rdata(4) <= \<const0>\;
  s_axi_rdata(3) <= \<const0>\;
  s_axi_rdata(2) <= \<const0>\;
  s_axi_rdata(1) <= \<const0>\;
  s_axi_rdata(0) <= \<const0>\;
  s_axi_rid(3) <= \<const0>\;
  s_axi_rid(2) <= \<const0>\;
  s_axi_rid(1) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_rvalid <= \<const0>\;
  s_axi_sbiterr <= \<const0>\;
  s_axi_wready <= \<const0>\;
  sbiterr <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst_blk_mem_gen: entity work.tile_rom_blk_mem_gen_v8_2_synth
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      clka => clka,
      douta(7 downto 0) => douta(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tile_rom is
  port (
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of tile_rom : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of tile_rom : entity is "tile_rom,blk_mem_gen_v8_2,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of tile_rom : entity is "tile_rom,blk_mem_gen_v8_2,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=blk_mem_gen,x_ipVersion=8.2,x_ipCoreRevision=6,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=artix7,C_XDEVICEFAMILY=artix7,C_ELABORATION_DIR=./,C_INTERFACE_TYPE=0,C_AXI_TYPE=1,C_AXI_SLAVE_TYPE=0,C_USE_BRAM_BLOCK=0,C_ENABLE_32BIT_ADDRESS=0,C_CTRL_ECC_ALGO=NONE,C_HAS_AXI_ID=0,C_AXI_ID_WIDTH=4,C_MEM_TYPE=3,C_BYTE_SIZE=9,C_ALGORITHM=1,C_PRIM_TYPE=1,C_LOAD_INIT_FILE=1,C_INIT_FILE_NAME=tile_rom.mif,C_INIT_FILE=tile_rom.mem,C_USE_DEFAULT_DATA=0,C_DEFAULT_DATA=0,C_HAS_RSTA=0,C_RST_PRIORITY_A=CE,C_RSTRAM_A=0,C_INITA_VAL=0,C_HAS_ENA=0,C_HAS_REGCEA=0,C_USE_BYTE_WEA=0,C_WEA_WIDTH=1,C_WRITE_MODE_A=WRITE_FIRST,C_WRITE_WIDTH_A=8,C_READ_WIDTH_A=8,C_WRITE_DEPTH_A=4096,C_READ_DEPTH_A=4096,C_ADDRA_WIDTH=12,C_HAS_RSTB=0,C_RST_PRIORITY_B=CE,C_RSTRAM_B=0,C_INITB_VAL=0,C_HAS_ENB=0,C_HAS_REGCEB=0,C_USE_BYTE_WEB=0,C_WEB_WIDTH=1,C_WRITE_MODE_B=WRITE_FIRST,C_WRITE_WIDTH_B=8,C_READ_WIDTH_B=8,C_WRITE_DEPTH_B=4096,C_READ_DEPTH_B=4096,C_ADDRB_WIDTH=12,C_HAS_MEM_OUTPUT_REGS_A=0,C_HAS_MEM_OUTPUT_REGS_B=0,C_HAS_MUX_OUTPUT_REGS_A=0,C_HAS_MUX_OUTPUT_REGS_B=0,C_MUX_PIPELINE_STAGES=0,C_HAS_SOFTECC_INPUT_REGS_A=0,C_HAS_SOFTECC_OUTPUT_REGS_B=0,C_USE_SOFTECC=0,C_USE_ECC=0,C_EN_ECC_PIPE=0,C_HAS_INJECTERR=0,C_SIM_COLLISION_CHECK=ALL,C_COMMON_CLK=0,C_DISABLE_WARN_BHV_COLL=0,C_EN_SLEEP_PIN=0,C_USE_URAM=0,C_EN_RDADDRA_CHG=0,C_EN_RDADDRB_CHG=0,C_EN_DEEPSLEEP_PIN=0,C_EN_SHUTDOWN_PIN=0,C_DISABLE_WARN_BHV_RANGE=0,C_COUNT_36K_BRAM=1,C_COUNT_18K_BRAM=0,C_EST_POWER_SUMMARY=Estimated Power for IP     _     2.326399 mW}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of tile_rom : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of tile_rom : entity is "blk_mem_gen_v8_2,Vivado 2015.2";
end tile_rom;

architecture STRUCTURE of tile_rom is
  signal NLW_U0_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_doutb_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_U0_s_axi_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of U0 : label is 12;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of U0 : label is 12;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of U0 : label is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of U0 : label is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of U0 : label is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of U0 : label is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of U0 : label is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of U0 : label is 0;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of U0 : label is "0";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of U0 : label is "1";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of U0 : label is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of U0 : label is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of U0 : label is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of U0 : label is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of U0 : label is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of U0 : label is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of U0 : label is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of U0 : label is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of U0 : label is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of U0 : label is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of U0 : label is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of U0 : label is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of U0 : label is "Estimated Power for IP     :     2.326399 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of U0 : label is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of U0 : label is 0;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of U0 : label is 0;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of U0 : label is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of U0 : label is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of U0 : label is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of U0 : label is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of U0 : label is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of U0 : label is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of U0 : label is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of U0 : label is "tile_rom.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of U0 : label is "tile_rom.mif";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of U0 : label is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of U0 : label is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 3;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of U0 : label is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of U0 : label is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of U0 : label is 4096;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of U0 : label is 4096;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of U0 : label is 8;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of U0 : label is 8;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of U0 : label is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of U0 : label is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of U0 : label is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of U0 : label is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of U0 : label is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of U0 : label is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of U0 : label is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of U0 : label is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of U0 : label is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of U0 : label is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of U0 : label is 0;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of U0 : label is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of U0 : label is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of U0 : label is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of U0 : label is 4096;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of U0 : label is 4096;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of U0 : label is 8;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of U0 : label is 8;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "artix7";
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is std.standard.true;
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
U0: entity work.tile_rom_blk_mem_gen_v8_2
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      addrb(11) => '0',
      addrb(10) => '0',
      addrb(9) => '0',
      addrb(8) => '0',
      addrb(7) => '0',
      addrb(6) => '0',
      addrb(5) => '0',
      addrb(4) => '0',
      addrb(3) => '0',
      addrb(2) => '0',
      addrb(1) => '0',
      addrb(0) => '0',
      clka => clka,
      clkb => '0',
      dbiterr => NLW_U0_dbiterr_UNCONNECTED,
      deepsleep => '0',
      dina(7) => '0',
      dina(6) => '0',
      dina(5) => '0',
      dina(4) => '0',
      dina(3) => '0',
      dina(2) => '0',
      dina(1) => '0',
      dina(0) => '0',
      dinb(7) => '0',
      dinb(6) => '0',
      dinb(5) => '0',
      dinb(4) => '0',
      dinb(3) => '0',
      dinb(2) => '0',
      dinb(1) => '0',
      dinb(0) => '0',
      douta(7 downto 0) => douta(7 downto 0),
      doutb(7 downto 0) => NLW_U0_doutb_UNCONNECTED(7 downto 0),
      eccpipece => '0',
      ena => '0',
      enb => '0',
      injectdbiterr => '0',
      injectsbiterr => '0',
      rdaddrecc(11 downto 0) => NLW_U0_rdaddrecc_UNCONNECTED(11 downto 0),
      regcea => '0',
      regceb => '0',
      rsta => '0',
      rstb => '0',
      s_aclk => '0',
      s_aresetn => '0',
      s_axi_araddr(31) => '0',
      s_axi_araddr(30) => '0',
      s_axi_araddr(29) => '0',
      s_axi_araddr(28) => '0',
      s_axi_araddr(27) => '0',
      s_axi_araddr(26) => '0',
      s_axi_araddr(25) => '0',
      s_axi_araddr(24) => '0',
      s_axi_araddr(23) => '0',
      s_axi_araddr(22) => '0',
      s_axi_araddr(21) => '0',
      s_axi_araddr(20) => '0',
      s_axi_araddr(19) => '0',
      s_axi_araddr(18) => '0',
      s_axi_araddr(17) => '0',
      s_axi_araddr(16) => '0',
      s_axi_araddr(15) => '0',
      s_axi_araddr(14) => '0',
      s_axi_araddr(13) => '0',
      s_axi_araddr(12) => '0',
      s_axi_araddr(11) => '0',
      s_axi_araddr(10) => '0',
      s_axi_araddr(9) => '0',
      s_axi_araddr(8) => '0',
      s_axi_araddr(7) => '0',
      s_axi_araddr(6) => '0',
      s_axi_araddr(5) => '0',
      s_axi_araddr(4) => '0',
      s_axi_araddr(3) => '0',
      s_axi_araddr(2) => '0',
      s_axi_araddr(1) => '0',
      s_axi_araddr(0) => '0',
      s_axi_arburst(1) => '0',
      s_axi_arburst(0) => '0',
      s_axi_arid(3) => '0',
      s_axi_arid(2) => '0',
      s_axi_arid(1) => '0',
      s_axi_arid(0) => '0',
      s_axi_arlen(7) => '0',
      s_axi_arlen(6) => '0',
      s_axi_arlen(5) => '0',
      s_axi_arlen(4) => '0',
      s_axi_arlen(3) => '0',
      s_axi_arlen(2) => '0',
      s_axi_arlen(1) => '0',
      s_axi_arlen(0) => '0',
      s_axi_arready => NLW_U0_s_axi_arready_UNCONNECTED,
      s_axi_arsize(2) => '0',
      s_axi_arsize(1) => '0',
      s_axi_arsize(0) => '0',
      s_axi_arvalid => '0',
      s_axi_awaddr(31) => '0',
      s_axi_awaddr(30) => '0',
      s_axi_awaddr(29) => '0',
      s_axi_awaddr(28) => '0',
      s_axi_awaddr(27) => '0',
      s_axi_awaddr(26) => '0',
      s_axi_awaddr(25) => '0',
      s_axi_awaddr(24) => '0',
      s_axi_awaddr(23) => '0',
      s_axi_awaddr(22) => '0',
      s_axi_awaddr(21) => '0',
      s_axi_awaddr(20) => '0',
      s_axi_awaddr(19) => '0',
      s_axi_awaddr(18) => '0',
      s_axi_awaddr(17) => '0',
      s_axi_awaddr(16) => '0',
      s_axi_awaddr(15) => '0',
      s_axi_awaddr(14) => '0',
      s_axi_awaddr(13) => '0',
      s_axi_awaddr(12) => '0',
      s_axi_awaddr(11) => '0',
      s_axi_awaddr(10) => '0',
      s_axi_awaddr(9) => '0',
      s_axi_awaddr(8) => '0',
      s_axi_awaddr(7) => '0',
      s_axi_awaddr(6) => '0',
      s_axi_awaddr(5) => '0',
      s_axi_awaddr(4) => '0',
      s_axi_awaddr(3) => '0',
      s_axi_awaddr(2) => '0',
      s_axi_awaddr(1) => '0',
      s_axi_awaddr(0) => '0',
      s_axi_awburst(1) => '0',
      s_axi_awburst(0) => '0',
      s_axi_awid(3) => '0',
      s_axi_awid(2) => '0',
      s_axi_awid(1) => '0',
      s_axi_awid(0) => '0',
      s_axi_awlen(7) => '0',
      s_axi_awlen(6) => '0',
      s_axi_awlen(5) => '0',
      s_axi_awlen(4) => '0',
      s_axi_awlen(3) => '0',
      s_axi_awlen(2) => '0',
      s_axi_awlen(1) => '0',
      s_axi_awlen(0) => '0',
      s_axi_awready => NLW_U0_s_axi_awready_UNCONNECTED,
      s_axi_awsize(2) => '0',
      s_axi_awsize(1) => '0',
      s_axi_awsize(0) => '0',
      s_axi_awvalid => '0',
      s_axi_bid(3 downto 0) => NLW_U0_s_axi_bid_UNCONNECTED(3 downto 0),
      s_axi_bready => '0',
      s_axi_bresp(1 downto 0) => NLW_U0_s_axi_bresp_UNCONNECTED(1 downto 0),
      s_axi_bvalid => NLW_U0_s_axi_bvalid_UNCONNECTED,
      s_axi_dbiterr => NLW_U0_s_axi_dbiterr_UNCONNECTED,
      s_axi_injectdbiterr => '0',
      s_axi_injectsbiterr => '0',
      s_axi_rdaddrecc(11 downto 0) => NLW_U0_s_axi_rdaddrecc_UNCONNECTED(11 downto 0),
      s_axi_rdata(7 downto 0) => NLW_U0_s_axi_rdata_UNCONNECTED(7 downto 0),
      s_axi_rid(3 downto 0) => NLW_U0_s_axi_rid_UNCONNECTED(3 downto 0),
      s_axi_rlast => NLW_U0_s_axi_rlast_UNCONNECTED,
      s_axi_rready => '0',
      s_axi_rresp(1 downto 0) => NLW_U0_s_axi_rresp_UNCONNECTED(1 downto 0),
      s_axi_rvalid => NLW_U0_s_axi_rvalid_UNCONNECTED,
      s_axi_sbiterr => NLW_U0_s_axi_sbiterr_UNCONNECTED,
      s_axi_wdata(7) => '0',
      s_axi_wdata(6) => '0',
      s_axi_wdata(5) => '0',
      s_axi_wdata(4) => '0',
      s_axi_wdata(3) => '0',
      s_axi_wdata(2) => '0',
      s_axi_wdata(1) => '0',
      s_axi_wdata(0) => '0',
      s_axi_wlast => '0',
      s_axi_wready => NLW_U0_s_axi_wready_UNCONNECTED,
      s_axi_wstrb(0) => '0',
      s_axi_wvalid => '0',
      sbiterr => NLW_U0_sbiterr_UNCONNECTED,
      shutdown => '0',
      sleep => '0',
      wea(0) => '0',
      web(0) => '0'
    );
end STRUCTURE;
