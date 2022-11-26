echo ""
figlet -c -f mono9 "RUDRA" | lolcat
echo " 								"
echo ""

echo	" 1.  subdomain Enumerations		2. Talk with DNS		3.  nuclei		"	
echo	" 4.  Links with http & https       	5. waybackurls            	6.  URL Grabber					"
echo	" 7.  naabu   				8. aquatone               	9.  hakrawler						"
echo	" 10. Fuzzing	 			11. Web content discovery	12. Network Mapping/ Active & Passive Recon  "
echo	" 13. XSS Scanner			14. Domain Finder		15. arjun"
echo	" 16. LinkFinder			17. secretfinder		18. ParamSpider"
echo	" 19. Corsy 				20. gitgraber 			21. byp4xx"
echo	" 22. Subjack            		23. Crawl Websites              24. Gxss   "    
echo	" 25. AutoMode(perform automated scan )         			200.Install & Setup Tools  " 
echo    ""
echo -n "Enter the respective number from tool list that you want to use: "
read number
echo ""

case $number in
	1)
		echo -n "Enter the domain: "
		read domain
             	subfinder -d $domain -o output.txt
		;;

	2)
		echo -n "Enter the domain: "
		read domain
             	subfinder -d $domain | dnsx -cname -resp
		;;
          
	3)
		echo -n "Enter the domain: "
		read domain
             	echo "$domain" | nuclei -t nuclei-templates -o $domain.txt
		;;
	
	4)
		echo -n "Enter the domain: "
		read domain
             	echo "$domain" | httpx -silent
		;;

	5)
		echo -n "Enter the domain: "
		read domain
             	echo "$domain" | waybackurls > $domain.txt
		;;

	6)
		echo -n "Enter the domain: "
		read domain
             	gau -o $domain.txt $domain
		;;

	7)
		echo -n "Enter the domain: "
		read domain
             	naabu -host $domain
		;;

	8)
		echo -n "Enter the domain: "
		read domain
             	echo "$domain" | aquatone
		;;

	9)
		echo -n "Enter the domain: "
		read domain
              	hakrawler -url $domain -depth 1
		;;

	10)
		echo -n "Enter the domain: "
		read domain
             	ffuf -w ~/Rudra/Wordlists/rockyou.txt -u https://$domain/FUZZ -o ffuf_res.txt
		;;
	11)
		echo -n "Enter the domain: "
		read domain
		python3 ~/Tools/dirsearch/dirsearch.py -u $domain -e all
		;;
	
	12)
		echo -n "Enter the domain: "
		read domain
		amass intel -d $domain -whois -o output.txt
		;;

	13)
		echo -n "Enter the domain: "
		read domain
		dalfox url http://$domain -b hahwul.xss.ht
		;;

	14)
		echo -n "Enter the domain: "
		read domain
		findomain -t $domain -o findomain.txt
		;;

	15)
		echo -n "Enter the domain: "
		read domain
		arjun -u https://$domain
		;;


	16)
		echo -n "Enter the domain: "
		read domain
		python3 ~/Tools/LinkFinder/linkfinder.py -i https://$domain -d 
		;;

	17)
		echo -n "Enter the domain: "
		read domain
		python3 ~/Tools/SecretFinder/SecretFinder.py -i $domain -o output.html
		;;

	18)
		echo -n "Enter the domain: "
		read domain
		python3 ~/Tools/ParamSpider/paramspider.py --domain $domain
		;;

	19)
		echo -n "Enter the domain: "
		read domain
		python3 ~/Tools/Corsy/corsy.py -u https://$domain
		;;

	
	20)
		echo -n "Enter the domain: "
		read domain
		python3 ~/Tools/gitGraber/gitGraber.py -k keywordsfile.txt \"$domain\" -s
		;;

	21)
		echo -n "Enter the URL: "
		read  url
		~/Tools/byp4xx/./byp4xx.sh $url
		;;
		
	22) 
	
        	echo -n "Enter your file: "
		read  file
		subjack -w $file -t 100 -timeout 30 -o results.txt -ssl
		;;
       
       23)
		echo -n "Enter the domain: "
		read domain
		gospider -s http://$domain -q -t 50 -c 100 --other-source -v -o output.txt
		;;
      
       24)
		echo -n "file with urls path "
		read file
		cat file | Gxss -c 100 -p Xss -h "Cookie: Value" -u "Google Bot" -o potxss.txt
		;;
       25)
		echo  "Enter the domain: "
		read domain
		mkdir $domain
		cd $domain
		mkdir hosts osint subdomains vulns webs ;
             echo  "Gathering subdomain using amass";
	      amass intel -d $domain -whois -o subdomains/subs_amass.txt;	      
	     echo "Gathering subdomain using subfinder for "$domain ;
              subfinder -d $domain -o subdomains/subs_subfinder.txt ;                     
             echo "creating list of subdomain from amass and subfinder"
             cat sudomains/subs_amass.txt subdomains/subs_subfinder.txt |sort -u >subdomains/subdomains.txt  
        
	      echo "using Httpx to find live hosts."
               httpx -l subdomains/subdomains.txt -o hosts/hosts.txt	
              
             echo "Using nuclei to find cves and common vulnerabilites"
               nuclei -l hosts/hosts.txt -o vulns/nuclei_result.txt
 
             echo "saving web urls from waybackurls and gau in webs " 
		  cat subdomains/subdomains.txt |waybackurls >webs/waybackurls.txt
		  cat subdomains/subdomains.txt |gau >webs/gau.txt
		  
		echo "finding url with reflected parameters "
		   cat webs/waybackurls.txt webs/gau.txt | httpx -silent | Gxss -c 100 -p Xss |sort -u |>webs/reflected_urls.txt
		   	   
		mkdir webs/pattern;
		    cat webs/waybackurls.txt webs/gau.txt | parth --pipe xss | uro > webs/pattern/xss.txt
			cat webs/waybackurls.txt webs/gau.txt | parth --pipe open_redirect | uro > webs/pattern/open_redirect.txt
			cat webs/waybackurls.txt webs/gau.txt | parth --pipe rce | uro > webs/pattern/rce.txt
			cat webs/waybackurls.txt webs/gau.txt | parth --pipe sqli | uro > webs/pattern/sqli.txt
			cat webs/waybackurls.txt webs/gau.txt | parth --pipe ssrf| uro > webs/pattern/ssrf.txt
			cat webs/waybackurls.txt webs/gau.txt | parth --pipe lfi | uro > webs/pattern/lfi.txt
		
		echo "Performing OSINT using google_dorks and emailfinder"
              ~/Tools/degoogle_hunter/degoogle_hunter.sh $domain | tee osint/dorks.txt
		sed -r -i "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" osint/dorks.txt
              emailfinder -d $domain > osint/emails.txt
              
              ;;

       200) 
	
        	~/Rudra/installer.sh
        	;;
		
	*)	
		echo "Please give valid choice!!!"
		;;

esac
