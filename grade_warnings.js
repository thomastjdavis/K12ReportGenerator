	/*
	Changes the background color of rows with falling grades to "ff3333"
	TO DO: add log message with students who are failing
*/
	var failing = 'The following students are currently failing:';
	var improve = 'The following students need to improve their averages:'
function warnings(){
	tbls = document.getElementsByClassName("course_table")
	stds = document.getElementsByTagName("h2")
	var len = tbls["length"]
	
	var i,j
	
	for(i=0; i<len; i++){
		len1 = tbls[i]["rows"].length
		show_name = true
		for(j=1;j<len1;j++){
			
			str = tbls[i]["rows"][j]["cells"][3]["textContent"]
			str2 = tbls[i]["rows"][j]["cells"][4]["textContent"]
			var perc = parseFloat(str)
			var perc2 = parseFloat(str2)
			if(perc<= 70.0){
				if(show_name){
					failing += stds[i].innerHTML
					show_name = false
				}
				failing += tbls[i]["rows"][j]["cells"][0]["innerHTML"] 
				failing += str 
				tbls[i]["rows"][j]["cells"][3]["innerHTML"]=emph(str)
				for(k=0;k<7;k++){
					tbls[i]["rows"][j]["cells"][k]["bgColor"]="ff2e2e"
				}
				continue;
			}
			if(perc< 90.0){
				if(show_name){
					improve += stds[i].innerHTML
					show_name = false
				}
				improve += tbls[i]["rows"][j]["cells"][0]["innerHTML"] 
				improve += str 
				tbls[i]["rows"][j]["cells"][3]["innerHTML"]=emph(str)
				for(k=0;k<7;k++){
					tbls[i]["rows"][j]["cells"][k]["bgColor"]="ffe055"
				}	
			}
			if(perc2<4.0){
				tbls[i]["rows"][j]["cells"][4]["bgColor"]="55eedd"
				tbls[i]["rows"][j]["cells"][4]["innerHTML"]= emph(str2)
			}
		}		
	}
	
}

function emph(str){
	return "*"+str+"*"
}

 let saveFile = () => {
        
        // This variable stores all the data.
        let data = failing+improve
        
        // Convert the text to BLOB.
        const textToBLOB = new Blob([data], { type: 'text/plain' });
        const sFileName = 'progress_notes.txt';	   // The file to save the data.

        let newLink = document.createElement("a");
        newLink.download = sFileName;

        if (window.webkitURL != null) {
            newLink.href = window.webkitURL.createObjectURL(textToBLOB);
        }
        else {
            newLink.href = window.URL.createObjectURL(textToBLOB);
            newLink.style.display = "none";
            document.body.appendChild(newLink);
        }

        newLink.click(); 
    }
