<div>
<table class="asst-table-v2">
<tr> <th> Assignment </th> <th> Problems </th> </tr>
{%for asst in site.data.assignments %}
<tr>
	<td class="first-col">
		<div class="asst-title-box"><b>{{asst.title | markdownify}}</b></div>
		{% assign due = '**Due:** ' | append: asst.due %}
		<div class="due-box">{{due | markdownify}}</div>
	</td>
	<td>{{asst.assignment | markdownify}}</td>
</tr>
{% endfor %}
</table>
</div>
<!-- <tr valign="top">
	<td  style="text-align: center">{{ asst.week | markdownify }}</td>
	<td>{{asst.assignment | markdownify}}</td>
	<td>{% if asst.due %}{{asst.due | markdownify}}{% endif %}</td>
</tr> -->
