{ config, pkgs, ... }:
{
	networking.hostName = "metaton";
	networking.extraHosts = ''
		192.168.1.94    lappy
		192.168.1.96    kageneko  kn  kagethecat
		192.168.1.215   wiiu
		192.168.1.216   3ds
		'';

}

