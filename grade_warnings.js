	/*
	Changes the background color of rows with falling grades to "ff3333"
	TO DO: add log message with students who are failing
*/
function warnings(){
	tbls = document.getElementsByClassName("course_table")
	var len = tbls["length"]
	var i,j
	for(i=0; i<len; i++){
		len1 = tbls[i]["rows"].length
		for(j=1;j<len1;j++){
			str = tbls[i]["rows"][j]["cells"][3]["textContent"]
			str2 = tbls[i]["rows"][j]["cells"][4]["textContent"]
			var perc = parseFloat(str)
			var perc2 = parseFloat(str2)
			if(perc<= 70.0){
				tbls[i]["rows"][j]["cells"][3]["innerHTML"]=emph(str)
				for(k=0;k<7;k++){
					tbls[i]["rows"][j]["cells"][k]["bgColor"]="ff2e2e"
				}				
			}
			if(perc2<2.0){
				tbls[i]["rows"][j]["cells"][4]["bgColor"]="55eedd"
				tbls[i]["rows"][j]["cells"][4]["innerHTML"]= emph(str2)
			}
		}		
	}	
}

function emph(str){
	return "*"+str+"*"
}