include:
  - ghost.install

{% for site in ghost.blogs %}
ghost-{{ site }}:
  file.managed:
    - name: {{ ghost.root }}/sites/{{ site }}/config.js
    - source: salt://ghost/files/config.js.jinja
    - mode: 644
{% endfor %}

