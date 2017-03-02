keepalived:
  {% if grains['nodename'] == 'mlb' %}
  ROUTEID: haproxy_ha
  STATEID: MASTER
  PRIORITYID: 150
  {% elif grains['nodename'] == 'slave1' %}
  ROUTEID: haproxy_ha
  STATEID: BACKERUP
  PRIORITYID: 100
  {% endif %}
  VIP: 192.168.200.20
