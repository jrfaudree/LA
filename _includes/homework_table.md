{% assign data = include.data %}
<table class="asst-table">
{% for homework in data.homework %}
<tr>
  <td><a href="{{ data.home }}/{{ homework.url }}"><b>{{ homework.name }}</b></a> &nbsp; &nbsp; Due {{ homework.due }}.
  </td>
</tr>
{% endfor %}
</table>
