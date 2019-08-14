$HOSTNAME = ""
params.outdir = 'results'  


if (!params.dir){params.dir = ""} 

Channel.fromPath(params.dir, type: 'any').map{ file -> tuple(file.baseName, file) }.set{g_3_reads_g_5}


process lstest {

publishDir params.outdir, overwrite: true, mode: 'copy',
	saveAs: {filename ->
	if (filename =~ /.*.txt$/) "list/$filename"
}

input:
 set val(name), file(reads) from g_3_reads_g_5

output:
 file "*.txt"  into g_5_dirlist

"""
#shell example: 

#!/bin/sh 
ls -l ${reads} > ${name}.txt
"""
}


workflow.onComplete {
println "##Pipeline execution summary##"
println "---------------------------"
println "##Completed at: $workflow.complete"
println "##Duration: ${workflow.duration}"
println "##Success: ${workflow.success ? 'OK' : 'failed' }"
println "##Exit status: ${workflow.exitStatus}"
}
