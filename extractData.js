function getData(){
	ct = document.getElementsByClassName("course_table")
	n = ct.length
	
	/* find the course names, prep file
	   need to watch for changes in ordering, insertion/deletion of courses */
	var course_list = []
	var grades = []
	var ppcs = []
	num_courses = ct[0]["rows"].length-1
	
	for (org =1; org<num_courses;org++){
		course_list.push(ct[0]["rows"][org]["cells"][0]["innerText"])
		grades[org-1] = [parseFloat(ct[0]["rows"][1]["cells"][3]["innerText"])]
		ppcs[org-1] = [parseFloat(ct[0]["rows"][1]["cells"][4]["innerText"])]
	}
	
	var ind
	
	for (i=1; i<n-1;i++){
		//number of rows of data
		ctl = ct[i]["rows"].length - 1
		
		for (j=1;j<=ctl;j++){
			name = ct[i]["rows"][j]["cells"][0]["innerText"]
			grade = ct[i]["rows"][j]["cells"][3]["innerText"]
			ppc =   ct[i]["rows"][j]["cells"][3]["innerText"]
			function isName(a) {
				return a==name
			}
			if (course_list.includes(name)) {
				ind = course_list.findIndex(isName)
			} else {
				course_list.push(name)
				ind = course_list.length - 1
				grades[ind]=[undefined]
				ppcs[ind]=[undefined]
				for(count=1;count<i;count++){
					grades[ind].push(undefined)
				}				
			}
			console.log(i)
			console.log(j)
				grades[ind].push(parseFloat(grade))
				ppcs[ind].push(parseFloat(ppc))			
			
		}
	}
	var course_data = []
	for (c=0;c<course_list.length;c++){
		course_data[c]=[course_list[c]]
		course_data[c].push(grades[c])
	}
	for (c=course_list.length;c<2*course_list.length;c++){
		course_data[c]=[course_list[c]]
		course_data[c].push(ppcs[c])
	}
	return course_data
}

 let saveFile = () => {
        
        // This variable stores all the data.
        let data = getData()
		
        
        // Convert the text to BLOB.
        const textToBLOB = new Blob([data], { type: 'text/plain' });
        const sFileName = 'data******.txt';	   // The file to save the data.

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