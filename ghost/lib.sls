{% macro ghostport(site) -%}
  {{ ghost.blogs.index(site) + 2368 }}
{%- endmacro %}

