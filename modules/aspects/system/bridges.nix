{
  # Host bridges that guests (e.g. microVMs) can attach to. Producers own the
  # bridge; consumers only rely on this record:
  #
  #   {
  #     name = "br0";                     # interface name
  #     unit = "foo.service";             # optional: unit that creates/configures it
  #     vlans = [ 10 20 ];                # optional: VLANs a guest may join as an
  #   }                                   #   access port; null = no VLAN filtering
  den.quirks.bridges.description = "Host bridges guests can attach to";
}
