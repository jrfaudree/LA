{% assign data = include.data %}
<table class="asst-table">
{% for dailylog in data.dailylog %}
<tr>
  <td><a href="{{ data.home }}/{{ dailylog.url }}"><b>{{ dailylog.name }}</b></a> &nbsp; &nbsp; {{ dailylog.date }}.
  </td>
</tr>
{% endfor %}
</table>
