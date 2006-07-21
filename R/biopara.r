biopara <- function(bioparatarget = "default",bioparasource=36000, bioparanruns = 39000, bioparafxn = list())
{
	options("warn" = -1);
###############################Config##############################################
###################################################################################
###################################################################################
###################################################################################
###################################################################################
	if(bioparatarget=="help")
	{
		print(noquote("In order to operate the master, you will need to define 5 variables."));
		print(noquote("These are:"));
		print(noquote("1. Master Working Directory"));
		print(noquote("2. Hostname of Master"));
		print(noquote("3. Port Number for Master to communicate with workers on"));
		print(noquote("4. Port Number for Master to communicate with clients on"));
		print(noquote("5. List of objects (worker's hostname,worker R install dir,worker tmpdir, worker port)"));
		print(noquote(""));
#		print(noquote("bioparatargdir is the working directory of the master:"));
#		print(noquote("bioparatargdir <- \"/home/biopara/tmp\";"));
		print(noquote("bioparamastername is the hostname of the master as the workers would see it:"));
		print(noquote("bioparamastername <- \"master-host-name\";"));
		print(noquote("bioparamasterport is the port used by the master to recieve worker connections"));
		print(noquote("bioparamasterport <- 36000;"));
		print(noquote("bioparaclientport is the port used by clients to connect to master."));
		print(noquote("bioparaclientport <- 39000;"));
		print(noquote("format for the main config list is"));
		print(noquote("list(list(\"computer-name\",worker-out-port,\"worker working directory\",worker-in-port,\"command that can be executed from master to launch worker session on remote computer\"),....)"));
		print(noquote("Example: for 2 workers compute-0-0 and compute-0-1,"));
		print(noquote("both having R installed in /opt/r, with working directory in /tmp and using port 38000."));
		print(noquote(""));
		print(noquote("bioparaconfig <- list(list(\"compute-0-0\",37000,\"/tmp\",38000,\"ssh -f compute-0-0 runwkr.sh\"),list(\"compute-0-1\",37000,\"/tmp\",38000,\"ssh -f compute-0-1 runwkr.sh\"));"));
		print(noquote(""));		
		print(noquote("The following is an example command string that passes through ssh to accomplish the worker launch"));		
		print(noquote("\"ssh -f compute-0-1 \\\" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \\\" 1> /dev/null 2>/dev/null \""));
		print(noquote("The octal allows the quotes, ()'s and ; characters to pass through ssh gracefully"));		
		print(noquote("The piping of stdin and stdout is necessary to not clutter the master screen"));		
		print(noquote(""));		
		print(noquote("After defining these elements you must either:"));
		print(noquote("1. Manually start your workers"));
		print(noquote("2. Rely on your start commands to start the workers"));
		print(noquote("The master will only incorporate workers present at launchtime"));
		print(noquote("Finally run the following command to start your master:"));
		print(noquote(""));
		print(noquote("biopara(bioparamastername,bioparamasterport,bioparaclientport,bioparaconfig)"));
		return();
	}
###############################Master##############################################
###################################################################################
###################################################################################
###################################################################################
###################################################################################
	if((typeof(bioparatarget)=="character")&&(typeof(bioparasource)=="double")&&(typeof(bioparanruns)=="double")&&(typeof(bioparafxn)=="list"))
	{	
###################################Master config#################################
print("Master mode")
		bioparatargdir <- getwd();
		bioparamastername <- bioparatarget;
		bioparamasterport <- bioparasource;
		bioparaclientport <- bioparanruns;
		bioparaconfig <- bioparafxn;

		bioparatargdir <- getwd();
#		bioparamastername <- "rescluster2"
#		bioparamasterport <- 36000;
#		bioparaclientport <- 39000;
#		bioparaconfig <- list(
#          		list("compute-0-0",37000,"/tmp",38000,"ssh -f compute-0-0 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-1",37000,"/tmp",38000,"ssh -f compute-0-1 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-2",37000,"/tmp",38000,"ssh -f compute-0-2 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-3",37000,"/tmp",38000,"ssh -f compute-0-3 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#                        list("compute-0-4",37000,"/tmp",38000,"ssh -f compute-0-4 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#                        list("compute-0-5",37000,"/tmp",38000,"ssh -f compute-0-5 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-6",37000,"/tmp",38000,"ssh -f compute-0-6 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-7",37000,"/tmp",38000,"ssh -f compute-0-7 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-8",37000,"/tmp",38000,"ssh -f compute-0-8 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-9",37000,"/tmp",38000,"ssh -f compute-0-9 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-10",37000,"/tmp",38000,"ssh -f compute-0-10 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-11",37000,"/tmp",38000,"ssh -f compute-0-11 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-12",37000,"/tmp",38000,"ssh -f compute-0-12 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-13",37000,"/tmp",38000,"ssh -f compute-0-13 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-14",37000,"/tmp",38000,"ssh -f compute-0-14 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-15",37000,"/tmp",38000,"ssh -f compute-0-15 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-16",37000,"/tmp",38000,"ssh -f compute-0-16 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-17",37000,"/tmp",38000,"ssh -f compute-0-17 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-18",37000,"/tmp",38000,"ssh -f compute-0-18 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-19",37000,"/tmp",38000,"ssh -f compute-0-19 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-20",37000,"/tmp",38000,"ssh -f compute-0-20 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "),
#			list("compute-0-21",37000,"/tmp",38000,"ssh -f compute-0-21 \" echo -e  'source\\50\\42/tmp/biopara.r\\42\\51\\73biopara\\50 37000,\\42/tmp\\42,\\42rescluster2\\42,38000\\51\\73'|/opt/R/bin/R --vanilla \" 1> /dev/null 2>/dev/null "));

##############################end master config#################################
print("Master is alive and configured");
#print("ls is");
#print(ls());
		bioparanumberofservers <- sum(nchar(nchar(nchar(nchar(nchar(bioparaconfig))))))
print("cleaning up");
		bioparanumservers <- 0;
		bioparasocketsuccess <-0;
	        setwd(bioparatargdir);
	        bioparasvrsocketlist <- list();
	        bioparacntsocketlist <- list();
###############################Socket creation####################################
		for (bioparaiterator in 1:bioparanumberofservers)
		{
			bioparathecommand <- bioparaconfig[[bioparaiterator]][[5]];
print(bioparathecommand);
			try(system(bioparathecommand, ignore.stderr = TRUE),silent=TRUE);
		}
Sys.sleep(5)
		for (bioparaiterator in 1:bioparanumberofservers)
		{
print("bioparaiterator is");
print(bioparaiterator);
print("host is");
print(bioparaconfig[[bioparaiterator]][[1]]);
print("port is"); 
print(as.double(bioparaconfig[[bioparaiterator]][[4]]))

			try({bioparaclientsocket<- socketConnection(host = bioparaconfig[[bioparaiterator]][[1]], port = as.double(bioparaconfig[[bioparaiterator]][[4]]), server = FALSE);bioparasocketsuccess<-1;},silent=TRUE);
			if(bioparasocketsuccess == 1 && bioparaclientsocket != 0)
			{
print("the bioparaclientsocket is");
print(bioparaclientsocket);
				writeLines("-1", bioparaclientsocket);
print("port is");
print(as.double(bioparaconfig[[bioparaiterator]][[2]]));
				bioparaserversocket <- socketConnection(host = "localhost", port= as.double(bioparaconfig[[bioparaiterator]][[2]]), server = TRUE);
print("the bioparaserversocket is");
print(bioparaserversocket);
				bioparanumservers <- bioparanumservers+1; 
				bioparasvrsocketlist[[bioparanumservers]] <- bioparaserversocket;
				bioparacntsocketlist[[bioparanumservers]] <- bioparaclientsocket;
				bioparaclientsocket<-0;
				bioparaserversocket<-0;
			}
			else
			{
print("an error in connecting to this host");
				next;
			}
#print("bioparasvrsocketlist is");
#print(bioparasvrsocketlist);
#print("bioparacntsocketlist is");
#print(bioparacntsocketlist);
		}
		remove("bioparanumberofservers");
		bioparanumberofhostslockedout <- 0;
print("number of servers is");
print(bioparanumservers);
################################end of socket creation#############################
		if (file.exists(paste(bioparatargdir,"/lastuser.r",sep="")))
		{
print("Found lastuser file");
			load(paste(bioparatargdir,"/lastuser.r",sep=""));
			bioparasize <- sum(nchar(nchar(nchar(bioparalastuseronsystem))));
			bioparalastuseronsystem[[bioparasize+1]] <- paste("Server restarted on: ",date(), sep="");					
			save(bioparalastuseronsystem, file=paste(bioparatargdir,"/lastuser.r",sep=""));
		}
		else
		{
print("Lastuser file not found making new lastuser file");
			bioparalastuseronsystem = list();
			bioparalastuseronsystem[[1]] <- paste("Server restarted on: ",date(), sep="");				
			save(bioparalastuseronsystem, file=paste(bioparatargdir,"/lastuser.r",sep=""));
		}
print("Entering Main Loop");
####################################Client connection############################
        	while(1)
        	{
        		bioparasocketsuccess <-0;
#print("bioparatargdir is")
#print(bioparatargdir)
print("Waiting for a client connection on bioparaclientport")
			bioparaclientserversocket <-  socketConnection(host = "localhost", port= bioparaclientport, server = TRUE);
print("Client connection established, waiting signal return");
			bioparaclientclientname <- readLines(bioparaclientserversocket, n=1);
print("Remote host is");
print(bioparaclientclientname);
			bioparaclientclientport <- readLines(bioparaclientserversocket, n=1);
print("Remote port is");
print(bioparaclientclientport);
			Sys.sleep(1);
print("Signal recieved, connecting to client");
			try({bioparaclientclientsocket <- socketConnection(host = bioparaclientclientname , port= as.double(bioparaclientclientport), server = FALSE);bioparasocketsuccess <-1;},silent=TRUE);
print("Client socket established");
			if(bioparasocketsuccess==1)
			{
				if((file.exists(paste(bioparatargdir,"/",bioparaclientclientname,".allow",sep="")))||(file.exists(paste(bioparatargdir,"/all.allow",sep=""))))
				{
					while(1)
					{
print("Reading data:");
						bioparamystring <- readLines(con=bioparaclientserversocket, n=1);
print(bioparamystring);
						if(as.double(bioparamystring) == -1)
						{
							break;
						}
						else
						{
							bioparasocketsuccess<-0;
							bioparamystring <- readLines(con=bioparaclientserversocket, n = as.double(bioparamystring));
#eval(parse(text=bioparamystring));
							bioparasocketsuccess<-try({eval(parse(text=bioparamystring));bioparasocketsuccess <-1;},silent=TRUE);
							if(bioparasocketsuccess == 0)
							{
								bioparaparrans <- bioparamystring;
								break;
							}
						}
					}
#Just a command to suspend our qeues
#system("/opt/sge/bin/glinux/qmod -s compute-0-0.q c-0-0.q compute-0-1.q c-0-1.q compute-0-2.q c-0-2.q compute-0-3.q c-0-3.q compute-0-4.q c-0-4.q compute-0-5.q c-0-5.q compute-0-6.q c-0-6.q compute-0-7.q c-0-7.q compute-0-8.q c-0-8.q compute-0-9.q c-0-9.q compute-0-10.q c-0-10.q compute-0-11.q c-0-11.q compute-0-12.q c-0-12.q compute-0-13.q c-0-13.q compute-0-14.q c-0-14.q compute-0-15.q c-0-15.q compute-0-16.q c-0-16.q compute-0-17.q c-0-17.q compute-0-18.q c-0-18.q compute-0-19.q c-0-19.q compute-0-20.q c-0-20.q compute-0-21.q c-0-21.q");
				}
				else
				{
print("Bad permissions on client connection. Client hostname.allow or all.allow does not exist in CWD");
					try(close(bioparaclientserversocket),silent=TRUE);
					try(close(bioparaclientclientsocket),silent=TRUE);
					next;
				}
			}
			else
			{
print("Cannot attach to client socket")
				try(close(bioparaclientserversocket),silent=TRUE);
				next;
			}
			try(close(bioparaclientclientsocket),silent=TRUE);
			remove("bioparasocketsuccess");
#print("ls is");
#print(ls());
##################################End client connection###################################
print("Entering main block, the function is");
print(bioparafxn);
			bioparacomputation <- 1;
			if (bioparafxn[[1]] == "last")
			{
print("Processing last");
				load(paste(bioparatargdir,"/lastuser.r",sep=""));
				bioparatheanswer <- bioparalastuseronsystem;
				bioparacomputation <- 0;
			}
			if (bioparafxn[[1]]=="numservers")
			{
print("Processing numservers");
				bioparatheanswer <- bioparanumservers - bioparanumberofhostslockedout;
				bioparacomputation <- 0;
			}
			if(bioparafxn[[1]]=="hosts")
                     	{
print("Processing hosts");
				bioparatheanswer <- list("If you see this, something broke")
				bioparatheanswer<- showConnections(all=FALSE);
				bioparacomputation <- 0;
			}
			if (bioparafxn[[1]]=="reset")
			{
				bioparatheanswer <- "environment reset";
print("Processing reset");
				bioparamystring <- paste("#",bioparausrname , "#reset#", sep="");
				for (bioparaitersave in 1:bioparanumservers)
				{
					bioparaclientsocket <- bioparacntsocketlist[[bioparaitersave]];
print("Talking to worker:");
print(bioparaclientsocket);
					if(bioparaclientsocket != -1)
					{
						writeLines(bioparamystring, con = bioparaclientsocket);
					}
				}
#				bioparatheanswer <- "environment reset";
				bioparacomputation <- 0;
			}
			if(bioparafxn[[1]]=="setenv")
			{
print("Processing setenv");
print("Current environment is");
print(ls());
#				bioparatheanswer <- "variables transmitted: ok";
				bioparathelist <- list("if-you-see-this-something-broke");
				bioparasizeoftheitem <- list("if-you-see-this-something-broke");
				bioparanumberofitems <- 0;
				bioparavarslist = ls();
				for(bioparaiterator in 1:sum(nchar(nchar(nchar(nchar(nchar(nchar(bioparavarslist))))))))
				{
					if({bioparavarslist[[bioparaiterator]] != "bioparathelist"}&&{bioparavarslist[[bioparaiterator]] != "bioparaclientclientname"}&&{bioparavarslist[[bioparaiterator]] != "bioparaclientclientport"}&&{bioparavarslist[[bioparaiterator]] != "bioparavarslist"}&&{bioparavarslist[[bioparaiterator]] != "bioparanumberofitems"}&&{bioparavarslist[[bioparaiterator]] != "bioparasizeoftheitem"}&&{bioparavarslist[[bioparaiterator]] != "bioparamystring"}&&{bioparavarslist[[bioparaiterator]] != "bioparanumservers"}&&{bioparavarslist[[bioparaiterator]] != "bioparalastuseronsystem"}&&{bioparavarslist[[bioparaiterator]] != "bioparasvrsocketlist"}&&{bioparavarslist[[bioparaiterator]] != "bioparacntsocketlist"}&&{bioparavarslist[[bioparaiterator]] != "bioparatarget"}&&{bioparavarslist[[bioparaiterator]] != "command"}&&{bioparavarslist[[bioparaiterator]] != "bioparathecommand"}&&{bioparavarslist[[bioparaiterator]] != "bioparanruns"}&&{bioparavarslist[[bioparaiterator]] != "bioparatarget"}&&{bioparavarslist[[bioparaiterator]] != "bioparafxn"}&&{bioparavarslist[[bioparaiterator]] != "files"}&&{bioparavarslist[[bioparaiterator]] != "file"}&&{bioparavarslist[[bioparaiterator]] != ".Traceback"}&&{bioparavarslist[[bioparaiterator]] != "last.warning"}&&{bioparavarslist[[bioparaiterator]] != "biopara"}&&{bioparavarslist[[bioparaiterator]] != "acommand"}&&{bioparavarslist[[bioparaiterator]] != "bioparabackthen"}&&{bioparavarslist[[bioparaiterator]] != "bioparaclientport"}&&{bioparavarslist[[bioparaiterator]] != "bioparacomputation"}&&{bioparavarslist[[bioparaiterator]] != "bioparaconfig"}&&{bioparavarslist[[bioparaiterator]] != "bioparaiterator"}&&{bioparavarslist[[bioparaiterator]] != "bioparamastername"}&&{bioparavarslist[[bioparaiterator]] != "bioparasource"}&&{bioparavarslist[[bioparaiterator]] != "bioparasize"}&&{bioparavarslist[[bioparaiterator]] != "bioparasshcommand"}&&{bioparavarslist[[bioparaiterator]] != "bioparatargdir"}&&{bioparavarslist[[bioparaiterator]] != "bioparabookkeeping"}&&{bioparavarslist[[bioparaiterator]] != "bioparaclientclientsocket"}&&{bioparavarslist[[bioparaiterator]] != "bioparaclientserversocket"}&&{bioparavarslist[[bioparaiterator]] != "bioparaclientsocket"}&&{bioparavarslist[[bioparaiterator]] != "bioparacounter"}&&{bioparavarslist[[bioparaiterator]] != "bioparacurrentsocket"}&&{bioparavarslist[[bioparaiterator]] != "bioparafirsttimetoreturn"}&&{bioparavarslist[[bioparaiterator]] != "bioparagotone"}&&{bioparavarslist[[bioparaiterator]] != "bioparaisfirstreturn"}&&{bioparavarslist[[bioparaiterator]] != "bioparaitersave"}&&{bioparavarslist[[bioparaiterator]] != "bioparanrepairs"}&&{bioparavarslist[[bioparaiterator]] != "bioparanumruns"}&&{bioparavarslist[[bioparaiterator]] != "biopararightnow"}&&{bioparavarslist[[bioparaiterator]] != "bioparaserversocket"}&&{bioparavarslist[[bioparaiterator]] != "bioparasizetodo"}&&{bioparavarslist[[bioparaiterator]] != "bioparatempbookkeeping"}&&{bioparavarslist[[bioparaiterator]] != "bioparatemptodo"}&&{bioparavarslist[[bioparaiterator]] != "bioparatheanswer"}&&{bioparavarslist[[bioparaiterator]] != "bioparatodolist"}&&{bioparavarslist[[bioparaiterator]] != "bioparausrname"}&&{bioparavarslist[[bioparaiterator]] != "bioparamasterport"}&&{bioparavarslist[[bioparaiterator]] != "bioparanumberofhostslockedout"})
					{
print("This is out current variable:");
print(bioparavarslist[[bioparaiterator]]);
print("Dumping it to file");
						dump(bioparavarslist[[bioparaiterator]]);
print("Reading it back in to memory as text");
						bioparanumberofitems <- bioparanumberofitems +1;
print("Itemlist incremented");
						bioparathelist[[bioparanumberofitems]] <- readLines(con="dumpdata.R");
#print("The current list set");
						bioparasizeoftheitem[[bioparanumberofitems]] <- toString(sum(nchar(nchar(nchar(nchar(bioparathelist[[bioparanumberofitems]]))))));
#print("itemsize set");
					}
				}
print("Number of items in this environment is");
print(bioparanumberofitems);
print("Writing the environment to the workers");
				if(bioparanumberofitems == 0)
				{
				}
				else
				{
					for (bioparaitersave in 1:bioparanumservers)
					{
						bioparaclientsocket <- bioparacntsocketlist[[bioparaitersave]];
print("Talking to worker:");
print(bioparaclientsocket);
						if(bioparaclientsocket != -1)
						{
#print("it is live")
#print("bioparaitersave is");
#print(bioparaitersave);
							bioparamystring <- paste("#",bioparausrname , "#setenv#", sep="");
							writeLines(bioparamystring, con = bioparaclientsocket);
							for(bioparaiterator in 1:bioparanumberofitems)
							{
								writeLines(bioparasizeoftheitem[[bioparaiterator]], con=bioparaclientsocket);
								writeLines(bioparathelist[[bioparaiterator]], con= bioparaclientsocket);
							}
							writeLines("-1", bioparaclientsocket);
						}
					}
				}
				file.remove(paste(bioparatargdir,"/tempvars.r",sep=""));
				bioparacurrentvars <- ls();
#print("bioparacurrentvars is");
#print(bioparacurrentvars);
				bioparasize <- sum(nchar(nchar(nchar(bioparacurrentvars))));
				for  (bioparaiterator in 1:bioparasize)
				{
					if("bioparacntsocketlist" == bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparaclientclientsocket" == bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparaclientserversocket" == bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparasvrsocketlist" == bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("numberofhostlockedout" == bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparanumservers" == bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparatargdir"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparausrname"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparafxn"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparaclientport"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparanumberofhostslockedout"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparaclientclientname"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
					if("bioparaclientclientport"== bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] <- "bioparacurrentvarplaceholder";
					}
				}
				remove(list = bioparacurrentvars);
				bioparatheanswer <- "variables transmitted ok";
#print("bioparacurrentvars is");
#print(ls());
				bioparacomputation <- 0;
			}
#######################################Begin processing##########################################
                        if(bioparacomputation == 1)  
                        {
print("Processing computation run");
print("User name is");
print(bioparausrname);
print("Function is");
print(bioparafxn);
print("Number of runs is :");
print(bioparanruns);					
#print("ls is");
#print(ls());
				bioparanrepairs <- 0;
				bioparaisfirstreturn <- 1;
				bioparabookkeeping <- list();
				bioparatodolist <- list();
				bioparasizetodo <- 0;
				bioparafirsttimetoreturn <- -1;
				bioparatheanswer <- list("if-you-see-this-something-broke");
				bioparasize <- sum(nchar(nchar(nchar(bioparafxn))));
	       			if (bioparasize > 1)
        			{
        				bioparanruns <- bioparasize;
        			}
print("Initial job creation");
#print("bioparafxn[[1]] is");
#print(bioparafxn[[1]]);					
				for (bioparaitersave in 1:bioparanruns) 
				{	
#print("parsing bioparafxn");
		        		if (bioparasize > 1)
					{
						bioparathecommand <- (bioparafxn[[bioparaitersave]]);
					}
					else
					{
						bioparathecommand <- (bioparafxn[[1]]);
					}
					bioparamystring <- paste("#", bioparausrname , "#", bioparathecommand, "#",  sep="");
#print("bioparamystring command is");
#print(bioparamystring);
#print("bioparatodolist is:");
#print(bioparatodolist);
#print("writing command:");
					biopararightnow <- Sys.time();
					bioparatodolist[[bioparaitersave]] <- list(bioparamystring, bioparaitersave, biopararightnow, 0, 0,0);
#print("bioparatodolist is:");
#print(bioparatodolist);
#print("bioparatodolist[[bioparaitersave]] is");
#print(bioparatodolist[[bioparaitersave]]);
#print("timestamp is");
#print(biopararightnow);
				}
print("Todo list generation is done");
				bioparanumruns <- 1;
				bioparacounter <- sum(nchar(nchar(nchar(bioparabookkeeping))));
				bioparasizetodo <- sum(nchar(nchar(nchar(bioparatodolist))));
				remove("bioparaparrans");
print("Entering return busy loop");
#print("bioparanumruns is");
#print(bioparanumruns);
print("Runs till return is");
print(bioparanruns +1);
print("The current counter is");
print(bioparacounter);
#print("bioparanumruns < (bioparanruns + 1)");
#print(bioparanumruns < (bioparanruns + 1));
#######################################Begin run mainloop################################
				while (bioparanumruns < (bioparanruns + 1))
				{
#print("while loop!");				
					bioparaiterator<-1;
					biopararightnow <- Sys.time();
#######################################Results check######################################
					while(1)
					{
						bioparagotone <- 0;
						if(bioparaiterator>bioparacounter)
						{
							break;
						}
print("Waiting");	
#print("bioparaiterator is");
#print(bioparaiterator);
#print("bioparabookkeeping is");
#print(bioparabookkeeping);
						bioparatempbookkeeping <- bioparabookkeeping[[bioparaiterator]];
print("trying for result");	
print(bioparatempbookkeeping[[5]]);
#print("bioparamystring is");
#print(bioparamystring)
						bioparamystring <- readLines(con=bioparatempbookkeeping[[5]],n=1);
						if(bioparamystring == "readytosend")
						{
print("Got result");
print("Trying to get answer");	
							if (bioparaisfirstreturn == 1)
							{
print("This is the first time answer");									
								biopararightnow <- Sys.time();
print("Right now is");
print(biopararightnow);
								bioparabackthen <- bioparatempbookkeeping[[3]];
print("Initial timestamp is");
print(bioparabackthen);
								bioparafirsttimetoreturn <- difftime(biopararightnow, bioparabackthen);
								if(bioparafirsttimetoreturn == 0)
								{
									bioparafirsttimetoreturn <- 1;
								}
print("Time to first return is");
print(bioparafirsttimetoreturn);
								bioparaisfirstreturn <- 0;
#print("bioparaisfirstreturn is");
#print(bioparaisfirstreturn);
							}
print("waiting for return size");
							bioparamystring <- readLines(con=bioparatempbookkeeping[[5]], n=1);
print("got it, it is");
print(bioparamystring);
print("double value is");
print(as.double(bioparamystring));
print("Waiting for data stream");
							bioparamystring <- readLines(con=bioparatempbookkeeping[[5]], n= as.double(bioparamystring));
print("Got it");
#print("bioparamystring is");
#print(bioparamystring)
#							eval(parse(text=bioparamystring));
print("Assigning answer to list");
print("Total runs is");	
#print(bioparanumruns);
							bioparatheanswer[[bioparatempbookkeeping[[2]]]] <- bioparamystring;
print("Assigned")
							remove("bioparaparrans");
print("bioparrans removed")
							if(sum(nchar(nchar(nchar(bioparabookkeeping)))) > 1)
							{
#print("bioparabookkeeping larger than 1. bioparabookkeeping is:");
#print(bioparabookkeeping);
								if(bioparaiterator == 1)
								{
									#bioparabookkeeping <- bioparabookkeeping[2:sum(nchar(nchar(nchar(bioparabookkeeping))))];						
									bioparabookkeeping[[1]] <-NULL;
									bioparacounter <- bioparacounter - 1;
								}
								else
								{
									if(bioparaiterator == sum(nchar(nchar(nchar(bioparabookkeeping)))))
									{
										bioparabookkeeping <- bioparabookkeeping[1:(bioparaiterator-1)];
#print("removing last element");
									}
									else
									{
#print("not removing last element");
										bioparabookkeeping <- c(bioparabookkeeping[1:(bioparaiterator-1)], bioparabookkeeping[(bioparaiterator+1):sum(nchar(nchar(nchar(bioparabookkeeping))))]);
									}
									bioparacounter <- sum(nchar(nchar(nchar(bioparabookkeeping))));
								}
#print("bioparabookkeeping after the assignment is");
#print(bioparabookkeeping);
							}
							else
							{
#print("bioparabookkeeping is 1 or 0. new bioparabookkeeping is:");
								bioparabookkeeping = list();
#print(bioparabookkeeping);
								bioparacounter <- 0;
							}
							bioparacounter <- sum(nchar(nchar(nchar(bioparabookkeeping))));
							bioparanumruns <- bioparanumruns + 1;
#print("bioparasizetodo4 is");
#print(bioparasizetodo);
							if((bioparasizetodo != 0))
							{
#print("We are posting something to the cluster");	
#print("Size of our to-do list is");		
#print("bioparasizetodo1 is");	
#print(bioparasizetodo);	
								bioparacurrentsocket <- bioparatempbookkeeping[[4]];
								bioparatemptodo <- bioparatodolist[[1]];
print("Current item is");
print(bioparatemptodo);
								if(bioparasizetodo > 1)
								{
									bioparatodolist[[1]] <- NULL;
									bioparasizetodo <- bioparasizetodo -1;
								}
								else
								{
									bioparatodolist = list();
									bioparasizetodo <- 0;
								}
								bioparamystring <- bioparatemptodo[[1]];
print("Item to write is:");
print(bioparamystring);
print("Current worker is");
print(bioparacurrentsocket);
								writeLines(bioparamystring, con=bioparacurrentsocket);
print("Timestamp is");
print(biopararightnow);
								bioparabookkeeping[[bioparacounter+1]] <- list(bioparamystring, bioparatemptodo[[2]], biopararightnow, bioparatempbookkeeping[[4]], bioparatempbookkeeping[[5]],bioparatempbookkeeping[[6]]);
								bioparacounter <- sum(nchar(nchar(nchar(bioparabookkeeping))));
							}
							bioparaiterator <- 0;
						}
						else
						{
							if(bioparafirsttimetoreturn != -1)
							{
print("Going into the timechecking block");
								bioparabackthen <- bioparatempbookkeeping[[3]];
print("Right now is");
print(biopararightnow);
print("Original transmission time is");
print(bioparabackthen);
print("Comparing");
print(difftime(biopararightnow,bioparabackthen));
#print("doing time multiplication");
print("Threshhold is");
print((bioparafirsttimetoreturn*3));
#print((difftime(biopararightnow,bioparabackthen) > (bioparafirsttimetoreturn*3)));
	 							if((difftime(biopararightnow,bioparabackthen) > (bioparafirsttimetoreturn*3)))
	 							{
	 							
print("Host has not completed in a timely manner");			
print("The culprit is");	
print(bioparatempbookkeeping[[4]]);	
#print("bioparasizetodo before addition is");
#print(bioparasizetodo);
#print("bioparatodolist before addition is");
#print(bioparatodolist);
									bioparasizetodo <- sum(nchar(nchar(nchar(bioparatodolist))));
									bioparatodolist[[bioparasizetodo+1]] <- bioparabookkeeping[[bioparaiterator]];
									bioparasizetodo <- sum(nchar(nchar(nchar(bioparatodolist))));
									bioparacntsocketlist[[bioparatempbookkeeping[[6]]]] <- -1;
									bioparasvrsocketlist[[bioparatempbookkeeping[[6]]]] <- -1;
									bioparanumberofhostslockedout <- bioparanumberofhostslockedout +1;
#print("bioparatodolist after addition is");
#print(bioparatodolist);
#print("bioparasizetodo after addition is");
#print(bioparasizetodo);
#print("bioparaiterator is")
#print(bioparaiterator);
#print("bioparabookkeeping before attempted deletion is");
#print(bioparabookkeeping);
									if(sum(nchar(nchar(nchar(bioparabookkeeping)))) > 1)
									{
#print("bioparabookkeeping larger than 1. bioparabookkeeping is:");
#print(bioparabookkeeping);
										if(bioparaiterator == 1)
										{
											#bioparabookkeeping <- bioparabookkeeping[2:sum(nchar(nchar(nchar(bioparabookkeeping))))];						
											bioparabookkeeping[[1]] <- NULL;
											bioparacounter <- bioparacounter - 1;
										}
										else
										{
											if(bioparaiterator == sum(nchar(nchar(nchar(bioparabookkeeping)))))
											{
												bioparabookkeeping <- bioparabookkeeping[1:(bioparaiterator-1)];
#print("removing last element");
											}
											else
											{
												bioparabookkeeping <- c(bioparabookkeeping[1:(bioparaiterator-1)], bioparabookkeeping[(bioparaiterator+1):sum(nchar(nchar(nchar(bioparabookkeeping))))]);
											}
											bioparacounter <- sum(nchar(nchar(nchar(bioparabookkeeping))));
										}
#print("bioparabookkeeping after the assignment is");
#print(bioparabookkeeping);
									}
									else
									{
#print("bioparabookkeeping is 1 or 0. new bioparabookkeeping is:");
										bioparabookkeeping = list();
#print(bioparabookkeeping);
										bioparacounter <- 0;
									}
#print("bioparabookkeeping after deletion is");
#print(bioparabookkeeping);
									bioparanrepairs <- bioparanrepairs+1;
print("Number of timeouts so far is");
print(bioparanrepairs);
#print("bioparacounter is");
#print(bioparacounter);	
									bioparaiterator <- 0;
#print("END OF A REPLACEMENT");
									break;
								}
							}
						}
						bioparaiterator<-bioparaiterator+1;
					}
######################################end results check###################################
print("results checking is out of the way");
print("bioparacounter is");
print(bioparacounter);
######################################task creation#####################################
					if(bioparacounter == 0)
					{
print("Queue is empty, adding item");
						bioparaiterator<-1;
						while(1)
						{
							bioparaclientsocket <- bioparacntsocketlist[[bioparaiterator]];
							bioparaserversocket <- bioparasvrsocketlist[[bioparaiterator]];
							if((bioparaclientsocket != -1) && (bioparaserversocket != -1))
							{
#print("trying to get sockets and writers");	
#print(bioparaclientsocket);
print("Parsing functions");
#print("bioparanruns-bioparanumruns is");
#print(bioparanruns-bioparanumruns);
#print("bioparanumruns is");
#print(bioparanumruns);
								if(!(bioparasizetodo == 0))
								{
print("Entering new task creation");
#print("were redoing something 2");
									bioparatemptodo <- bioparatodolist[[1]];
print("Current item is");
print(bioparatemptodo);
									if(bioparasizetodo > 1)
									{
#print("trying to split bioparatodolist");
										bioparatodolist[[1]] <- NULL;
										bioparasizetodo <- bioparasizetodo - 1;
#print("bioparasizetodo2 is");
#print(bioparasizetodo);
									}
									else
									{
#print("bioparatodolist is size 1 or less");
										bioparatodolist = list();
										bioparasizetodo <- 0;
									}
									bioparamystring <- bioparatemptodo[[1]];
print("Current item is");
print(bioparamystring);
#print(bioparamystring);
									writeLines(bioparamystring, con=bioparaclientsocket);	
print("Timestamp is");
print(biopararightnow);
									bioparabookkeeping[[bioparacounter+1]] <- list(bioparamystring, bioparatemptodo[[2]], biopararightnow, bioparaclientsocket, bioparaserversocket, bioparaiterator);
									bioparacounter <- sum(nchar(nchar(nchar(bioparabookkeeping))));
print("Leaving task creation");
								}
							}
							bioparaiterator<-bioparaiterator+1
							if(bioparaiterator == bioparanumservers+1)
							{
								break;
							}
							if(bioparasizetodo == 0)
							{
								break;
							}
						}
					}
######################################End task creation##################################
print("Runs until completion is");	
print(bioparanumruns);	
print("Total runs is");	
print(bioparanruns +1);	
#print("got to break");
print("Total timeouts is");
print(bioparanrepairs);
#print("bioparacounter is");
#print(bioparacounter);
#print("bioparasizetodo3 is");
#print(bioparasizetodo);
#print("END OF LOOP");
				}
#####################################end all three##########################
			}
print("Out of the main retun loop");
			bioparaparrans <- bioparatheanswer;
print("Dumping answer to file");
			dump("bioparaparrans");
print("Reading it back in as text");
			bioparaparrans <- readLines(con="dumpdata.R");
#                        file.copy("dumpdata.R",paste("./",bioparausrname,Sys.time(),"output.R"),overwrite=TRUE);
#print("writing size to client");
			bioparasocketsuccess <- 0;
			try({bioparaclientclientsocket <- socketConnection(host = bioparaclientclientname , port= as.double(bioparaclientclientport), server = FALSE);bioparasocketsuccess <-1;},silent=TRUE);
			if(bioparasocketsuccess == 1)
			{
				writeLines(toString(sum(nchar(nchar(nchar(nchar(bioparaparrans)))))), bioparaclientclientsocket);
print("Writing data to client");
				writeLines(bioparaparrans, bioparaclientclientsocket);
#system("/opt/sge/bin/glinux/qmod -us compute-0-0.q c-0-0.q compute-0-1.q c-0-1.q compute-0-2.q c-0-2.q compute-0-3.q c-0-3.q compute-0-4.q c-0-4.q compute-0-5.q c-0-5.q compute-0-6.q c-0-6.q compute-0-7.q c-0-7.q compute-0-8.q c-0-8.q compute-0-9.q c-0-9.q compute-0-10.q c-0-10.q compute-0-11.q c-0-11.q compute-0-12.q c-0-12.q compute-0-13.q c-0-13.q compute-0-14.q c-0-14.q compute-0-15.q c-0-15.q compute-0-16.q c-0-16.q compute-0-17.q c-0-17.q compute-0-18.q c-0-18.q compute-0-19.q c-0-19.q compute-0-20.q c-0-20.q compute-0-21.q c-0-21.q");
			}
			else
			{
print("Client is not responding");
#system("/opt/sge/bin/glinux/qmod -us compute-0-0.q c-0-0.q compute-0-1.q c-0-1.q compute-0-2.q c-0-2.q compute-0-3.q c-0-3.q compute-0-4.q c-0-4.q compute-0-5.q c-0-5.q compute-0-6.q c-0-6.q compute-0-7.q c-0-7.q compute-0-8.q c-0-8.q compute-0-9.q c-0-9.q compute-0-10.q c-0-10.q compute-0-11.q c-0-11.q compute-0-12.q c-0-12.q compute-0-13.q c-0-13.q compute-0-14.q c-0-14.q compute-0-15.q c-0-15.q compute-0-16.q c-0-16.q compute-0-17.q c-0-17.q compute-0-18.q c-0-18.q compute-0-19.q c-0-19.q compute-0-20.q c-0-20.q compute-0-21.q c-0-21.q");
			}
			biopararightnow <- Sys.time();
print("Loading lastuser");
			load(paste(bioparatargdir,"/lastuser.r",sep=""));
			bioparasize <- sum(nchar(nchar(nchar(bioparalastuseronsystem))));
			bioparalastuseronsystem[[bioparasize+1]] <- paste("Last user was:", bioparausrname," on: " , biopararightnow," running: ", bioparafxn, sep="" );					
#print(bioparalastuseronsystem[[bioparasize+1]]);
print("Saving lastuser");
			save(file=paste(bioparatargdir,"/lastuser.r",sep=""), bioparalastuseronsystem);
			remove("bioparausrname");
			remove("bioparafxn");
			try(close(bioparaclientclientsocket),silent=TRUE);
			try(close(bioparaclientserversocket),silent=TRUE);
print("Lastuser saved");
print("Number of servers is");
print(bioparanumservers);		
print("Number of locked out workers is");
print(bioparanumberofhostslockedout);
remove("bioparaparrans");
		}
	}
#########################################Server code #################################
######################################################################################
######################################################################################
######################################################################################
######################################################################################
#biopara(37000,"/tmp","localhost",38000)
#function(bioparatarget,bioparasource=37000, bioparanruns = 38000, bioparafxn = list())

	if((typeof(bioparatarget)=="double")&&(typeof(bioparasource)=="character")&&(typeof(bioparanruns)=="character")&&(typeof(bioparafxn)=="double"))
	{
		bioparaworkerhostname<-system("hostname",intern=TRUE);
		bioparaworkingdir <- bioparasource;
print(paste(bioparaworkerhostname,": ","Server is alive"));
		options("warn" = -1);
		setwd(bioparaworkingdir);	
print(paste(bioparaworkerhostname,": ",getwd()));
print(paste(bioparaworkerhostname,": ","Beginning socket creation"));
		bioparaserversocket <- socketConnection(host = "localhost", port= bioparafxn, server = TRUE);
print(paste(bioparaworkerhostname,": ","Server socket got picked up"));
print(paste(bioparaworkerhostname,": ",bioparaserversocket));
		bioparamystring <- readLines(con=bioparaserversocket, n=1);
		Sys.sleep(1);
		bioparaclientsocket <- socketConnection(host = bioparanruns, port= bioparatarget, server = FALSE);
print(paste(bioparaworkerhostname,": ","Client socket got picked up"));
print(paste(bioparaworkerhostname,": ",bioparaclientsocket));
		bioparacurrentuser = "nobody.yet"
		while (TRUE)
		{
			bioparaoutput = list();
			bioparacurrentvarplaceholder <- "";
print(paste(bioparaworkerhostname,": ","Waiting for command"));
			bioparamystring <- readLines(bioparaserversocket,n=1);
print(paste(bioparaworkerhostname,": ","Got one, it is"));
print(paste(bioparaworkerhostname,": ",bioparamystring));
			bioparatempvar<- nchar(bioparamystring);
			bioservecurrentindex <- 1;
			bioservenumberofrecieved <- 1;
			if(bioparamystring == "-1")
			{
				next;
			}

			for(bioparaiterator in 1:bioparatempvar)
			{
				if(substr(bioparamystring,bioparaiterator,bioparaiterator) == "#")
				{
					bioparaoutput[[bioservenumberofrecieved]]=substr(bioparamystring,(bioservecurrentindex+1),(bioparaiterator-1)); 
					bioservenumberofrecieved <- bioservenumberofrecieved+1;
					bioservecurrentindex = bioparaiterator;
				}
			}
			bioparausrname <- bioparaoutput[[2]];
print(paste(bioparaworkerhostname,": ","User name is"));
print(paste(bioparaworkerhostname,": ",bioparausrname));
			bioparathecommand <- bioparaoutput[[3]];
print(paste(bioparaworkerhostname,": ","The command is"));
print(paste(bioparaworkerhostname,": ",bioparathecommand));
			if({bioparausrname != bioparacurrentuser}||{bioparathecommand == "reset"})
			{
print(paste(bioparaworkerhostname,": ","This user is different from our current user"));
				bioparacurrentvars <- ls(envir = globalenv());
#				bioparacurrentvars <- ls();
#print("currenvars is");
#print(bioparacurrentvars);
				bioparasize <- sum(nchar(nchar(nchar(bioparacurrentvars))))
				for(bioparaiterator in 1:bioparasize)
				{
					if("bioparaserversocket"== bioparacurrentvars[[bioparaiterator]])
					{		
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
					if("bioparaworkerhostname"== bioparacurrentvars[[bioparaiterator]])
					{		
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
					if("bioparaclientsocket" ==  bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
					if("bioparacurrentuser" ==  bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
					if("bioparausrname" ==  bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
					if("bioparathecommand" ==  bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
					if("bioparaworkingdir" ==  bioparacurrentvars[[bioparaiterator]])
					{
						bioparacurrentvars[[bioparaiterator]] = "bioparacurrentvarplaceholder";
					}
				}
#print("currenvars after prune is");
#print(bioparacurrentvars);
				bioparacurrentuser <- bioparausrname;
				remove(list=bioparacurrentvars);
				if(bioparathecommand == "reset")
				{
					try(file.remove(paste(bioparaworkingdir,"/",bioparausrname,".r",sep="")), silent=TRUE);
				}
				else
				{
					try(load(paste(bioparaworkingdir,"/",bioparausrname,".r",sep="")), silent=TRUE);
#print("ls after load is");
#print(ls());
				}
			}
			else
			{
print(paste(bioparaworkerhostname,": ","This is the same user as before:"));
#print(bioparacurrentuser);
			}
			if({bioparathecommand == "setenv"}||{bioparathecommand == "reset"})
			{
print(paste(bioparaworkerhostname,": ","This is a setenv, ls is"));
print(paste(bioparaworkerhostname,": ",ls()));
				if(bioparathecommand == "reset")
				{
				}
				else
				{
					while(1)
					{
#print("before bioparamystring");
						bioparamystring <- readLines(con=bioparaserversocket, n=1);
#print("bioparamystring read,it is")
#print(bioparamystring);
						if(as.double(bioparamystring) == -1)
						{
print(paste(bioparaworkerhostname,": ","We got a -1, breaking loop"))
							break;
						}
						else
						{
print(paste(bioparaworkerhostname,": ","Not a -1, waiting for data"));
							bioparasocketsuccess = 0;
							bioparamystring <- readLines(con=bioparaserversocket, n = as.double(bioparamystring));
print(paste(bioparaworkerhostname,": ","Data recieved, evaluating"));
#print(bioparamystring);
							try({eval(parse(text=bioparamystring),envir = globalenv());bioparasocketsuccess <-1;},silent=TRUE);
#							try({eval(parse(text=bioparamystring));bioparasocketsuccess <-1;},silent=TRUE);
							if(bioparasocketsuccess == 0)
							{
								bioparatheanswer <- geterrmessage();
								break;
							}
print(paste(bioparaworkerhostname,": ","Evaluation done"));
						}
					}
print(paste(bioparaworkerhostname,": ","Environment loading done, ls is"));
print(paste(bioparaworkerhostname,": ",ls()));
print(paste(bioparaworkerhostname,": ","Saving file"));
					remove("bioparathecommand");
					try(save(file=paste(bioparausrname,".r",sep=""), list=ls()), silent=TRUE);
print(paste(bioparaworkerhostname,": ","Save done"));		
				}
			}
			else
			{
				bioparasystemscheck <- 0;
				bioparatempvar <- nchar(bioparathecommand);
				for(bioparaiterator in 1:bioparatempvar)
				{
					if(bioparaiterator+6>bioparatempvar)
					{
#print("Ran off the end, continuing");
						break;
					}
#print(substr(bioparathecommand,bioparaiterator,bioparaiterator+6));
					if(substr(bioparathecommand,bioparaiterator,bioparaiterator+6) == "system(")
					{
						bioparasystemscheck = 1;
						break;
					}
				}
				if(bioparasystemscheck == 1)
				{
					bioparaparrans <- "system() calls are not allowed";
print(paste(bioparaworkerhostname,": ","Recieved a system call, ignoring"));
#print(bioparaparrans);
					dump("bioparaparrans");
print(paste(bioparaworkerhostname,": ","Dumped answer"));
					bioparamystring <- readLines(con="dumpdata.R");
print(paste(bioparaworkerhostname,": ","Read back in a text"));
					writeLines("readytosend",bioparaclientsocket);
print(paste(bioparaworkerhostname,": ","Sent ready signal, writing answer"));
					writeLines(toString(sum(nchar(nchar(nchar(nchar(bioparamystring)))))), bioparaclientsocket);
print(paste(bioparaworkerhostname,": ","Size written"));
					writeLines(bioparamystring,bioparaclientsocket);
print(paste(bioparaworkerhostname,": ","Answer written"));
					remove("bioparamystring");
				}
				else
				{
print(paste(bioparaworkerhostname,": ","A computation run"));
print(paste(bioparaworkerhostname,": ","The current environment is"));
print(paste(bioparaworkerhostname,": ",ls()));
					remove("bioservecurrentindex ");
					remove(bioparatempvar);
					remove("bioparasystemscheck");
					remove(bioparaparrans);
					remove("bioparaexecsuccess");
print(paste(bioparaworkerhostname,": ","Beginning evaluation"));
					try({bioparaparrans <- eval(parse(text = bioparathecommand),envir = globalenv()); bioparaexecsuccess <-1}, silent=TRUE);
#					try({bioparaparrans <- eval(parse(text = bioparathecommand)); bioparaexecsuccess <-1}, silent=TRUE);
print(paste(bioparaworkerhostname,": ","Evaluation done"));
					if(!exists("bioparaexecsuccess"))
					{
print(paste(bioparaworkerhostname,": ","But there was an error"));
						bioparaparrans <- geterrmessage();
print(paste(bioparaworkerhostname,": ",bioparaparrans));
					}
print(paste(bioparaworkerhostname,": ","Dumping"));
					dump("bioparaparrans");                                     
print(paste(bioparaworkerhostname,": ","Dumped answer"));
					bioparamystring <- readLines(con="dumpdata.R");
print(paste(bioparaworkerhostname,": ","Read answer back in"));
					writeLines("readytosend",bioparaclientsocket);
print(paste(bioparaworkerhostname,": ","Sent ready signal, writing answer"));
					writeLines(toString(sum(nchar(nchar(nchar(nchar(nchar(nchar(nchar(nchar(nchar(nchar(bioparamystring)))))))))))), bioparaclientsocket);
print(paste(bioparaworkerhostname,": ","Size written"));
					writeLines(bioparamystring,bioparaclientsocket);
print(paste(bioparaworkerhostname,": ","Answer written"));
					remove("bioparamystring");
				}
			}
		}	
		quit("no"); 	
	}
########################################Client########################################
######################################################################################
######################################################################################
######################################################################################
######################################################################################
	else
	{
		if({typeof(bioparatarget)!="list"}&&{typeof(bioparasource)!="list"})
		{
			print(noquote("Error:The first 2 arguments to biopara should be lists."));
			print(noquote("The first should be list(\"master-host-name\",master-port)"));
			print(noquote("The second should be list(\"local-host-ip\",local-port)"));
			print(noquote("The local port can be any free port on your local machine"));
			return();
		}
		bioparaexecsuccess <- 0;
		bioparausrname <- noquote(paste(Sys.getenv("username"),Sys.getenv("USER"), sep=""));
		try({bioparausrname <- bioparatarget[[3]];},silent=TRUE);
print("Using username:");
print(bioparausrname);
		remove("bioparaexecsuccess");
#print("bioparausrname is");
#print(bioparausrname);
#print("Number of Runs is");
#print(bioparanruns);
print("The target is");
print(bioparatarget);
print("The source is");
print(bioparasource);
		bioparafxn <- bioparafxn;
		bioparatarget <- bioparatarget;
		bioparanruns <- bioparanruns;
		if(bioparafxn[[1]] == "setenv")
		{
print("This is a setenv")
#print("typeof(bioparanruns)");
#print(typeof(bioparanruns));
			if(typeof(bioparanruns)=="list")
			{
print("Setenv manual mode");
				bioparalist <- list("bioparafxn", "bioparanruns", "bioparausrname");
				bioparalist <- c(bioparalist,bioparanruns);
#print("Variables list is");
#print(bioparalist);
			}
			else
			{
print("Setenv all inclusive mode");
				bioparalist <- list("bioparafxn", "bioparanruns", "bioparausrname");
				bioparalist <- c(bioparalist, unlist((ls(all = TRUE, envir = parent.frame()))));
#print("Variables list is");
#print(bioparalist);		
			}
		}
		else
		{
print("Standard computation run");
			bioparalist <- list("bioparafxn", "bioparanruns", "bioparausrname");
		}
		if(typeof(bioparanruns)=="list")
		{
			bioparanruns <- 1;
		}
		else
		{	
			if(bioparanruns < 1)
			{
				bioparanruns <- 1;
			}
		}
		remove("bioparaparrans");
		bioparanumberofitems <-0;
		bioparathelist <- list("if-you-see-this-something-broke");
		bioparasizeoftheitem <- list("if-you-see-this-something-broke");
		for(bioparaiterator in 1:sum(nchar(nchar(nchar(nchar(nchar(nchar(bioparalist))))))))
		{
			bioparatempstring <- "";
			if({bioparalist[[bioparaiterator]] != ".Traceback"}&&{bioparalist[[bioparaiterator]] != "last.warning"}&&{bioparalist[[bioparaiterator]] != "..."}&&{bioparalist[[bioparaiterator]] != "biopara"})
			{
#print("Current item is");
#print(bioparalist[[bioparaiterator]]);
#print("Dumping it to file local environment");
#print(bioparanumberofitems)
				try({dump(bioparalist[[bioparaiterator]]);bioparanumberofitems <- bioparanumberofitems +1;bioparatempstring <- readLines(con="dumpdata.R");},silent=TRUE);
#print(bioparanumberofitems)
#print(bioparatempstring);
#print(paste(bioparatempstring,"",sep="") == "");
				if(paste(bioparatempstring,"",sep="") == "")
				{
#print("Dumping it to file parent environment");
					try({dump(bioparalist[[bioparaiterator]],envir = parent.frame());bioparanumberofitems <- bioparanumberofitems +1;bioparatempstring <- readLines(con="dumpdata.R");},silent=TRUE);
#print(bioparanumberofitems)
#print(bioparatempstring);
#print(paste(bioparatempstring,"",sep="") == "");
					if(paste(bioparatempstring,"",sep="") == "")					
					{
#print("Dumping it to file parent's parent environment");
						try({eval(dump(bioparalist[[bioparaiterator]],envir = parent.frame()),envir=parent.frame());bioparanumberofitems <- bioparanumberofitems +1;bioparatempstring <- readLines(con="dumpdata.R");},silent=FALSE);
#print(bioparanumberofitems)
#print(bioparatempstring);
#print(paste(bioparatempstring,"",sep="") == "");
						if(paste(bioparatempstring,"",sep="") == "")					
						{
#print("Dumping it to file global environment");
							try({dump(bioparalist[[bioparaiterator]],envir = globalenv());bioparanumberofitems <- bioparanumberofitems +1;bioparatempstring <- readLines(con="dumpdata.R");},silent=FALSE);
#print(bioparanumberofitems)
#print(bioparatempstring);
#print(paste(bioparatempstring,"",sep="") == "");
						}
					}
				}
#print("Reading it back in as text");
#print("Item count incremented");
				bioparathelist[[bioparanumberofitems]] <- bioparatempstring;
#print(bioparathelist[[bioparanumberofitems]])
#print("thelist set");
				bioparasizeoftheitem[[bioparanumberofitems]] <- toString(sum(nchar(nchar(nchar(nchar(bioparathelist[[bioparanumberofitems]]))))));
#print("itemsize set");
			}
		}
#print("Total items is")
#print(bioparanumberofitems);
print("Establishing client socket to master");
		Sys.sleep(2);
		bioparaclientsocket <- socketConnection(host = bioparatarget[[1]], port= bioparatarget[[2]], server = FALSE);
print("Socket established");
print("Writing hostname to master");
		writeLines(bioparasource[[1]], bioparaclientsocket);
print(bioparasource[[1]]);
print("Writing local port to master")
		writeLines(as.character(bioparasource[[2]]), bioparaclientsocket);
#print(as.character(bioparasource[[2]]))
print("Hostname and port written to master, waiting for return connection");
		bioparaserversocket <- socketConnection(host = "localhost", port=bioparasource[[2]] , server = TRUE);
print("Done, server is connected");
print(bioparaserversocket);
print("Writing data");
		for(bioparaiterator in 1:bioparanumberofitems)
		{
#print("Writing size");
			writeLines(bioparasizeoftheitem[[bioparaiterator]], bioparaclientsocket);
#print("Written");
#print("Writing data");
			writeLines(bioparathelist[[bioparaiterator]], con= bioparaclientsocket);
#print("Written");
		}
		writeLines("-1", bioparaclientsocket);
#print("Terminator written");
		try(close(bioparaserversocket),silent=TRUE);
print("Waiting for return connection");
		bioparaserversocket <- socketConnection(host = "localhost", port=bioparasource[[2]] , server = TRUE);
print("Waiting for answer size");
		bioparaparrans <- readLines(con=bioparaserversocket, n=1);
print("Answer size recieved it is");
print(bioparaparrans);
print("Coerced to double it is");
print(as.double(bioparaparrans));
print("Recieving data");
		bioparaparrans <- readLines(con=bioparaserversocket, n=as.double(bioparaparrans));
print("Answer recieved");
#print(bioparaparrans);
#                save(bioparaparrans, file="biopararrans.r");
		eval(parse(text=bioparaparrans));		
                bioparasizeoftheitem <- sum(nchar(nchar(nchar(nchar(nchar(nchar(nchar(nchar(nchar(bioparaparrans))))))))));
#print("bioparasizeoftheitem is");
#print(bioparasizeoftheitem);
                bioparaparranstemp <- bioparaparrans;
                bioparaparransoutput <- list();
#return(bioparaparranstemp);
		if(bioparasizeoftheitem == 1)
		{
			bioparaparransoutput<- bioparaparranstemp[[1]];	
			try({bioparaparransoutput<-eval(parse(text=bioparaparranstemp[[1]]));},silent=TRUE);
print("Answer processed");
		}
		else
		{
	                for(bioparaiterator in 1:bioparasizeoftheitem)
	                {
				bioparaparransoutput[[bioparaiterator]]<-bioparaparranstemp[[bioparaiterator]]
				try({bioparaparransoutput[[bioparaiterator]]<-eval(parse(text=bioparaparranstemp[[bioparaiterator]]));},silent=TRUE);
#				print(system.time(eval(parse(text=bioparaparranstemp[[bioparaiterator]]))))
	                }
print("Answer processed: local times above. These should be low");
		}
		try(close(bioparaclientsocket),silent=TRUE);
		try(close(bioparaserversocket),silent=TRUE);
		return(bioparaparransoutput);
	}
}
