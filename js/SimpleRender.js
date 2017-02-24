function MakeHTMLTableFromArray(Data, TableObject, IncludeHeader, fncHTMLEncode)
{
	var strTableHTML = "<tbody>";
	var strTableHTMLHeader = "";
	var objHeaders = [];
	// First, loop over the whole data array to find all possible properties.
	// Collect them in an object which we can iterate over to build rows.
	for (var i = 0; i < Data.length; i++)
	{
		strTableHTML += "<tr>";
		for (var prop in Data[i])
		{
			objHeaders[prop] = prop;
		}
		for (var header in objHeaders)
		{
			strTableHTML += "<td>" + fncHTMLEncode(Data[i][objHeaders[header]]) + "</td>";
		}
		strTableHTML += "</tr>";
	}
	if (typeof(IncludeHeader) === "boolean" ? IncludeHeader : true)
	{
		strTableHTMLHeader += "<thead><tr>";
		for (var header in objHeaders)
		{
			strTableHTMLHeader += "<th>" + fncHTMLEncode(objHeaders[header]) + "</th>";
		}
		strTableHTMLHeader += "</tr></thead>";
		strTableHTML = strTableHTMLHeader + strTableHTML;
	}
	strTableHTML += "</tbody>";
	TableObject.innerHTML = strTableHTML;
}