keepalived-install:
  pkg.installed:
    - names:
      - keepalived

keepalived-config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/keepalived/files/haproxy-outside-keepalived.conf
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    {% if grains['fqdn'] == 'linux-node1.example.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 150
    {% elif grains['fqdn'] == 'linux-node2.example.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKERUP
    - PRIORITYID: 100
    {% endif %}

check-haproxy-script:
  file.managed:
    - name: /etc/keepalived/check_haproxy.sh
    - source: salt://cluster/keepalived/files/check_haproxy.sh
    - user: root
    - group: root
    - mode: 755

keepalived-service:
  service.running:
    - name: keepalived
    - enable: True
    - reload: True
    - require:
      - pkg: keepalived-install
      - file: keepalived-config
      - file: check-haproxy-script
    - watch:
      - file: keepalived-config
