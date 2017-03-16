keepalived:
  {% if grains['nodename'] == 'mlb' %}
  ROUTEID: haproxy_ha
  INSTANCE_NAME: VI_1
  STATEID: MASTER
  ROUTER_ID: 51
  PRIORITYID: 150
  AUTH_TYPE: PASS
  AUTH_PASS: 1111
  {% elif grains['nodename'] == 'slave1' %}
  ROUTEID: haproxy_ha
  INSTANCE_NAME: VI_1
  STATEID: BACKERUP
  ROUTER_ID: 51
  PRIORITYID: 100
  AUTH_TYPE: PASS
  AUTH_PASS: 1111
  {% endif %}
  VIP: 192.168.200.20
