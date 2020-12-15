#TO DO:
#make it less "official" looking
#separate via subject level

#Niceities:
#export to csv for cool analysis


using Dates, Gumbo
#putting together progress reports

"""
g10_students::Dict{Int64,String}

dictionary containing g10 student names/ids
"""
g10_students = Dict(XXXXX1=>"student1",XXXXX2=>"student2",XXXXX3=>"student3",XXXXX4=>"student4 ",XXXXX5=>"student5",XXXXX6=>"student6",XXXXX7=>"student7",XXXXX8=>"student8",XXXXX9=>"student9")
"""
g11_students::Dict{Int64,String}

dictionary containing g11 student names/ids
"""
g11_students = Dict(XXXX1X=>"name1",XXXX2X=>"name2",XXXX3X=>"name3",XXXX4X=>"name4",XXXX5X=>"name5",XXXX6X=>"name6")


#running on wsl - can change
"""
header(date::String,f::IOStream)

Adds the header of the Keystone html files to IOStream.
Includes report run date.
See also: createMaster
"""
function header(date::String,f::IOStream)
write(f,"""<html>
<head>
<style>
#progress_report {
	font-family: Arial; 
	margin-left:15px;
	margin-right:15px;
	}
	
#progress_report p  { 
	width: 90%; 
	text-align: right
	}
	
#progress_report p.center  {
	width: 90%; 
	text-align: center
	}
	
#progress_report li.footer_list {
	list-style-type: circle;
	font-style: italic;
	font-weight: bold;
	}
	
@page {
	size:8.5in 11in;
	margin: 1mm;
	}
	
th.course_header{ 
	background-color: #80a1bf;
	border: 2px solid black;
	text-align: center;
	padding-left:5px;
	padding-top:5px;
	padding-right:5px;
	padding-bottom:5px;
	} 
table.course_table {
	width: 90%;
	border: 2px solid black;
	border-collapse: collapse;
	text-align: left;
	}
td.course_data {
	font-family: Arial;
	border: 2px solid black;
	border-collapse: collapse;
	padding-left:5px;
	padding-top:5px;
	padding-right:5px;
	padding-bottom:5px;
	}
td.right,th.right {
	text-align: right;
	width: 10%;
}
</style>
<script>
	/*
	Changes the background color of rows with falling grades to "ff3333"
		Grades that are between 70% and 90% are shaed to "ffeo55"
	*/
	var failing = 'The following students are currently failing:';
	var improve = 'The following students need to improve their averages:'
function warnings(){
	tbls = document.getElementsByClassName("course_table")
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
</script>

<div id="progress_report"><div align="center"><img src="https://key12.k12.com/i/logo_keystone_clear.png" alt="Keystone Logo"><p class="center">920 Central Road, Bloomsburg, PA 17815 <br>Phone (800) 255-4937<br>Fax (570) 300-2346<br>info@keystonehighschool.com - <a href="http://www.keystonehighschool.com">www.keystonehighschool.com</a><br></p></div>

</head>
<body onLoad="warnings()">
<div>
	<input type="button" id="bt" value="Click to download notes about the progress reports" onclick="saveFile()"/>
</div>""")
end

function createReport(students::Dict{Int64,String},grouping::String)
	
	f = open("$(grouping).html","w")
	
	header("12/1/2020",f)
	
	write(f,"<h1>$(grouping)'s progress</h1>")
	for value in keys(students)
		ID = "$value"
		docname = "keystone_progress_report_$ID"*".html"
		try
			file = parsehtml(read(docname,String))
			write(f,repr(Ref(file.root[2][1][2][2])))
			write(f,repr(Ref(file.root[2][1][2][4])))
			write(f,"<br><br>")
		catch e 
			write(f,"data for $(students[value]) not found <br><br><br>")
			continue
		end
	end

	close(f)
	println("$(grouping).html succesfully generated. ")	
	
end

function createMaster()
	#make sure the working directory is correct
	
	f = open("master_progress_current.html","w")
	report_log = open("master_progress_current.log","w")
	
	#adds the logo, info, and style information at the top 
	header("12/8/2020",f)
	
	
	print(f,"<h1>G10's Progress</h1>")
	print(report_log,"...Writing G10's progres...")
	for value in keys(g10_students)
		ID = "$value"
		docname = "keystone_progress_report_$ID"*".html"
		try
			file = parsehtml(read(docname,String))
			println("testing if $(g10_students[value]) has data available")
			
			str1 = repr(file.root[2][1][2][2])[21:end]
			str2 = repr(file.root[2][1][2][4])[21:end]
			println("data found!")
			println(f,"""<h2 align="center">$(g10_students[value]) data:</h2>\n""")
			println(f,str1)
			println(f,str2)
			println(f,"<br><br>")
		catch e 
			println(f,"data for $(g10_students[value]) not found <br><br><br>")
			println(report_log,"juliadata for $(g10_students[value]) not found")
			continue
		end
	end	
	
	write(f,"<h1>G11's Progress</h1>")

		for value in keys(g11_students)
		ID = "$value"
		docname = "keystone_progress_report_$ID"*".html"
		try
			file = parsehtml(read(docname,String))
			println("testing if $(g10_students[value]) has data available")
			
			str1 = repr(file.root[2][1][2][2])[21:end]
			str2 = repr(file.root[2][1][2][4])[21:end]
			println("data found!")
			println(f,"""<h2 align="center">$(g10_students[value]) data:</h2>\n""")
			println(f,str1)
			println(f,str2)
			println(f,"<br><br>")
		catch e 
			write(f,"data for $(g11_students[value]) not found <br><br><br>")
			println("data for $(g11_students[value]) not found")
			println(report_log,"juliadata for $(g11_students[value]) not found")
			continue
		end
	end	
	println(f,"<p>See source code at <b>github.com/thomastjdavis/K12ReportGenerator</b></p>")
	close(f)
	println("\n Master progress report assembled. ")
	 
	
	end
	
	
createMaster()
