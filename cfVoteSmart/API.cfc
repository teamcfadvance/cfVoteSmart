<cfcomponent displayname="API" name="API" hint="I am the VoteSmart API wrapper.">

	<!--- INITIALIZE --->
	<cffunction name="init" access="public" output="false" returntype="any" description="I am the constructor for the VoteSmart API wrapper.">
		<cfargument name="apiKey" type="string" required="true" hint="I am the API key provided to you by VoteSmart." />
		<cfargument name="apiUrl" type="string" required="false" default="http://api.votesmart.org/" hint="I am the URL for the API." />
		<cfargument name="format" type="string" required="false" default="JSON" hint="I am the format of the output to recieve from the API, one of: JSON or XML." />
		<cfargument name="debug" type="string" required="false" default="log" hint="I determine the debug level of the API, one of: none, log (default), throw or throwlog." />
		<cfargument name="logFile" type="string" required="false" default="cfVoteSmart" hint="I am the name of the file to log errors to, when debug level set to 'log' or 'throwlog'." />
		
		<cfset var variables.instance.apiKey = ARGUMENTS.apiKey />
		<cfset var variables.instance.apiUrl = ARGUMENTS.apiUrl />
		<cfset var variables.instance.format = ARGUMENTS.format />
		<cfset var variables.instance.debug = ARGUMENTS.debug />
		<cfset var variables.instance.logFile = ARGUMENTS.logFile />
		
		<cfreturn this />
	</cffunction>

	
	<!---                                            --->
	<!--- ADDRESS CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Address.html --->
	<!---                                            --->

	
	<!--- GET CAMPAIGN ADDRESSES --->
	<cffunction name="getAddressCampaign" access="public" output="false" returntype="struct" description="I implement the Address.getCampaign() method of the VoteSmart API. This method grabs campaign office(s) and basic candidate information for the specified candidate.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the id of the candidate to retrieve the campaign addresses for." />
		
		<cfset var addressObj =  do('Address','getCampaign',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(addressObj,'error')>
			<cfset handleError(addressObj) />
		</cfif>
	
		<cfreturn addressObj />
	
	</cffunction>
	
	<!--- GET CAMPAIGN WEB ADDRESSES --->	
	<cffunction name="getAddressCampaignWebAddress" access="public" output="false" returntype="struct" description="I implement the Address.getCampaignWebAddress() method of the VoteSmart API. This method grabs the campaign office's Web address(es) and basic candidate information for the specified candidate.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the id of the candidate to retrieve the campaign addresses for." />
		
		<cfset var addressObj =  do('Address','getCampaignWebAddress',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(addressObj,'error')>
			<cfset handleError(addressObj) />
		</cfif>
	
		<cfreturn addressObj />
	
	</cffunction>
	
	<!--- GET CAMPAIGN ADDRESSES BY ELECTION ID --->	
	<cffunction name="getAddressCampaignByElection" access="public" output="false" returntype="struct" description="I implement the Address.getCampaignByElection() method of the VoteSmart API.  This method grabs campaign office(s) and basic candidate information for the specified election.">
		<cfargument name="electionId" type="numeric" required="true" hint="I am the id of the election to retrieve the campaign addresses for." />
		
		<cfset var addressObj =  do('Address','getCampaignByElection',{ electionId = ARGUMENTS.electionId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(addressObj,'error')>
			<cfset handleError(addressObj) />
		</cfif>
	
		<cfreturn addressObj />
	
	</cffunction>
	
	<!--- GET OFFICE ADDRESSES --->
	<cffunction name="getAddressOffice" access="public" output="false" returntype="struct" description="I implement the Address.getOffice() method of the VoteSmart API. This method grabs office(s) and basic candidate information for the specified candidate.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the id of the candidate to retrieve the office addresses for." />
		
		<cfset var addressObj =  do('Address','getOffice',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(addressObj,'error')>
			<cfset handleError(addressObj) />
		</cfif>
	
		<cfreturn addressObj />
	
	</cffunction>
	
	<!--- GET OFFICE WEB ADDRESSES --->
	<cffunction name="getAddressOfficeWebAddress" access="public" output="false" returntype="struct" description="I implement the Address.getOfficeWebAddress() method of the VoteSmart API. This method grabs office's Web address(es) and basic candidate information for the specified candidate.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the id of the candidate to retrieve the office addresses for." />
		
		<cfset var addressObj =  do('Address','getOfficeWebAddress',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(addressObj,'error')>
			<cfset handleError(addressObj) />
		</cfif>
	
		<cfreturn addressObj />
	
	</cffunction>
	
	<!--- GET OFFICE BY OFFICE AND STATE --->
	<cffunction name="getAddressOfficeByOfficeState" access="public" output="false" returntype="struct" description="I implement the Address.getOfficeByOfficeState() method of the VoteSmart API. This method grabs office address and basic candidate information according to the officeId and state.">
		<cfargument name="officeId" type="numeric" required="true" hint="I am the id of the office to retrieve the office addresses for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve the office addresses for." />
		
		<cfset var addressObj =  do('Address','getOfficeWebAddress',{ candidateId = ARGUMENTS.candidateId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(addressObj,'error')>
			<cfset handleError(addressObj) />
		</cfif>
	
		<cfreturn addressObj />
	
	</cffunction>

	
	<!---                                            --->
	<!--- BALLOT MEASURE CLASS SECTION               --->
	<!--- http://api.votesmart.org/docs/Measure.html --->
	<!---                                            --->


	<!--- GET MEASURES BY YEAR AND STATE --->
	<cffunction name="getMeasuresByYearState" access="public" output="false" returntype="struct" description="I implement the Measure.getMeasuresByYearState() method of the VoteSmart API.  This method returns a list of state ballot measures in a given year.">
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve ballot measures for." />
		<cfargument name="stateId" type="numeric" required="true" hint="I am the state id to retrieve ballot measures for." />
		
		<cfset var measureObj =  do('Measure','getMeasuresByYearState',{ yearOf = ARGUMENTS.yearOf, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(measureObj,'error')>
			<cfset handleError(measureObj) />
		</cfif>
	
		<cfreturn measureObj />
	
	</cffunction>

	<!--- GET MEASURE --->
	<cffunction name="getMeasure" access="public" output="false" returntype="struct" description="I implement the Measure.getMeasure() method of the VoteSmart API. This method returns a single Ballot Measure detail.">
		<cfargument name="measureId" type="numeric" required="true" hint="I am the measure id to retrieve the ballot measure details for." />
		
		<cfset var measureObj =  do('Measure','getMeasure',{ measureId = ARGUMENTS.measureId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(measureObj,'error')>
			<cfset handleError(measureObj) />
		</cfif>
	
		<cfreturn measureObj />
	
	</cffunction>

	
	<!---                                                 --->
	<!--- CANDIDATE BIO CLASS SECTION                     --->
	<!--- http://api.votesmart.org/docs/CandidateBio.html --->
	<!---                                                 --->


	<!--- GET BIO --->
	<cffunction name="getCandidateBio" access="public" output="false" returntype="struct" description="I implement the CandidateBio.getBio() method of the VoteSmart API. This method grabs the main bio for each candidate.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve the biography details for." />
		
		<cfset var bioObj =  do('CandidateBio','getBio',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(bioObj,'error')>
			<cfset handleError(bioObj) />
		</cfif>
	
		<cfreturn bioObj />
	
	</cffunction>
	
	<!--- GET ADDITIONAL (EXTENDED) BIO --->
	<cffunction name="getCandidateAddlBio" access="public" output="false" returntype="struct" description="I implement the CandidateBio.getBio() method of the VoteSmart API. This method grabs the etended bio for each candidate that has one.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve the extended biography details for." />
		
		<cfset var bioObj =  do('CandidateBio','getAddlBio',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(bioObj,'error')>
			<cfset handleError(bioObj) />
		</cfif>
	
		<cfreturn bioObj />
	
	</cffunction>

	
	<!---                                               --->
	<!--- CANDIDATES CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Candidates.html --->
	<!---                                               --->	

	
	<!--- GET BY OFFICE AND STATE --->
	<cffunction name="getCandidatesByOfficeState" access="public" output="false" returntype="struct" description="I implement the Candidates.getByOfficeState() method of the VoteSmart API. This method grabs a list of candidates according to office and state representation.">
		<cfargument name="officeId" type="numeric" required="true" hint="I am the office id to retrieve candidates for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve candidates for." />
		<cfargument name="electionYear" type="numeric" required="false" default="" hint="I am the election year to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByOfficeState',{ officeId = ARGUMENTS.officeId, stateId = ARGUMENTS.stateId, electionYear = ARGUMENTS.electionYear, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>
	
	<!--- GET BY OFFICE TYPE AND STATE --->
	<cffunction name="getCandidatesByOfficeTypeState" access="public" output="false" returntype="struct" description="I implement the Candidates.getByOfficeTypeState() method of the VoteSmart API. This method grabs a list of candidates according to office type and state representation.">
		<cfargument name="officeTypeId" type="numeric" required="true" hint="I am the office type id to retrieve candidates for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve candidates for." />
		<cfargument name="electionYear" type="numeric" required="false" default="" hint="I am the election year to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByOfficeTypeState',{ officeTypeId = ARGUMENTS.officeTypeId, stateId = ARGUMENTS.stateId, electionYear = ARGUMENTS.electionYear, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>
	
	<!--- GET BY LAST NAME --->
	<cffunction name="getCandidatesByLastname" access="public" output="false" returntype="struct" description="I implement the Candidates.getByLastname() method of the VoteSmart API. This method grabs a list of candidates according to a lastname match.">
		<cfargument name="lastName" type="string" required="true" hint="I am the last name to retrieve candidates for." />
		<cfargument name="electionYear" type="numeric" required="false" default="" hint="I am the election year to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByLastname',{ lastName = ARGUMENTS.lastName, electionYear = ARGUMENTS.electionYear, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>
	
	<!--- GET BY FUZZY LAST NAME --->
	<cffunction name="getCandidatesByLevenshtein" access="public" output="false" returntype="struct" description="I implement the Candidates.getByLevenshtein() method of the VoteSmart API. This method grabs a list of candidates according to a fuzzy lastname match.">
		<cfargument name="lastName" type="string" required="true" hint="I am the last name to retrieve candidates for." />
		<cfargument name="electionYear" type="numeric" required="false" default="" hint="I am the election year to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByLevenshtein',{ lastName = ARGUMENTS.lastName, electionYear = ARGUMENTS.electionYear, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>
	
	<!--- GET BY ELECTION --->
	<cffunction name="getCandidatesByElection" access="public" output="false" returntype="struct" description="I implement the Candidates.getByElection() method of the VoteSmart API. This method grabs a list of candidates according to the election they are running in.">
		<cfargument name="electionId" type="numeric" required="true" hint="I am the election id to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByElection',{ electionId = ARGUMENTS.electionId, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>
	
	<!--- GET BY DISTRICT --->
	<cffunction name="getCandidatesByDistrict" access="public" output="false" returntype="struct" description="I implement the Candidates.getByDistrict() method of the VoteSmart API. This method grabs a list of candidates according to the district they represent.">
		<cfargument name="districtId" type="string" required="true" hint="I am the district id to retrieve candidates for." />
		<cfargument name="electionYear" type="numeric" required="false" default="" hint="I am the election year to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByDistrict',{ districtId = ARGUMENTS.districtId, electionYear = ARGUMENTS.electionYear, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>
	
	<!--- GET CANDIDATES BY ZIP --->
	<cffunction name="getCandidatesByZip" access="public" output="false" returntype="struct" description="I implement the Candidates.getByZip() method of the VoteSmart API. This method grabs a list of candidates according to the zip code they represent.">
		<cfargument name="zip5" type="string" required="true" hint="I am the 5 digit zip code to retrieve candidates for." />
		<cfargument name="electionYear" type="numeric" required="false" default="" hint="I am the election year to retrieve candidates for." />
		<cfargument name="zip4" type="string" required="false" default="" hint="I am the +4 for the zip code to retrieve candidates for." />
		<cfargument name="stageId" type="numeric" required="false" default="" hint="I am the stage id to retrive candidates for." />
		
		<cfset var candidateObj =  do('Candidates','getByZip',{ zip5 = ARGUMENTS.zip5, electionYear = ARGUMENTS.electionYear, zip4 = ARGUMENTS.zip4, stageId = ARGUMENTS.stageId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(candidateObj,'error')>
			<cfset handleError(candidateObj) />
		</cfif>
	
		<cfreturn candidateObj />
	
	</cffunction>

	
	<!---                                              --->
	<!--- COMMITTEE CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Committee.html --->
	<!---                                              --->

	
	<!--- GET COMMITTEE TYPES --->
	<cffunction name="getCommitteeTypes" access="public" output="false" returntype="struct" description="I implement the Committee.getTypes() method of the VoteSmart API. Returns the committee types(house, senate, joint, etc).">
		
		<cfset var committeeObj =  do('Committee','getTypes') />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(committeeObj,'error')>
			<cfset handleError(committeeObj) />
		</cfif>
	
		<cfreturn committeeObj />
	
	</cffunction>
	
	<!--- GET COMMITTEES BY TYPE AND STATE --->
	<cffunction name="getCommitteesByTypeState" access="public" output="false" returntype="struct" description="I implement the Committee.getCommitteesByTypeState() method of the VoteSmart API. Returns the list of committees that fit the criteria.">
		<cfargument name="typeId" type="numeric" required="false" default="" hint="I am the committee type id to return committees for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to return committees for." />
		
		<cfset var committeeObj =  do('Committee','getCommitteesByTypeState',{ typeId = ARGUMENTS.typeId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(committeeObj,'error')>
			<cfset handleError(committeeObj) />
		</cfif>
	
		<cfreturn committeeObj />
	
	</cffunction>
	
	<!--- GET COMMITTEE --->
	<cffunction name="getCommittee" access="public" output="false" returntype="struct" description="I implement the Committee.getCommittee() method of the VoteSmart API. Returns detailed committee data.">
		<cfargument name="committeeId" type="numeric" required="false" default="" hint="I am the committee id to return committee details for." />
		
		<cfset var committeeObj =  do('Committee','getCommittee',{ committeeId = ARGUMENTS.committeeId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(committeeObj,'error')>
			<cfset handleError(committeeObj) />
		</cfif>
	
		<cfreturn committeeObj />
	
	</cffunction>
	
	<!--- GET COMMITTEE MEMBERS --->
	<cffunction name="getCommitteeMembers" access="public" output="false" returntype="struct" description="I implement the Committee.getCommitteeMembers() method of the VoteSmart API. Returns members of the committee.">
		<cfargument name="committeeId" type="numeric" required="false" default="" hint="I am the committee id to return committee details for." />
		
		<cfset var committeeObj =  do('Committee','getCommitteeMembers',{ committeeId = ARGUMENTS.committeeId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(committeeObj,'error')>
			<cfset handleError(committeeObj) />
		</cfif>
	
		<cfreturn committeeObj />
	
	</cffunction>


	<!---                                             --->
	<!--- DISTRICT CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/District.html --->
	<!---                                             --->

	
	<!--- GET DISTRICT BY OFFICE AND STATE --->
	<cffunction name="getDistrictByOfficeState" access="public" output="false" returntype="struct" description="I implement the District.getByOfficeState() method of the VoteSmart API. This method grabs district IDs according to the office and state.">
		<cfargument name="officeId" type="numeric" required="true" hint="I am the office id to retrieve districts for." />
		<cfargument name="stateId" type="numeric" required="true" hint="I am the state id to retrieve districts for." />
		<cfargument name="districtName" type="string" required="false" default="" hint="I am the district name to retrieve districts for." />
		
		<cfset var districtObj =  do('District','getByOfficeState',{ officeId = ARGUMENTS.officeId, stateId = ARGUMENTS.stateId, districtName = ARGUMENTS.districtName }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(districtObj,'error')>
			<cfset handleError(districtObj) />
		</cfif>
	
		<cfreturn districtObj />
	
	</cffunction>
	
	<!--- GET DISTRICT BY ZIP --->
	<cffunction name="getDistrictByZip" access="public" output="false" returntype="struct" description="I implement the District.getByZip() method of the VoteSmart API. This method grabs district IDs according to the zip code.">
		<cfargument name="zip5" type="string" required="true" hint="I am the 5 digit zip code to retrieve districts for." />
		<cfargument name="zip4" type="string" required="false" default="" hint="I am the +4 for the zip code to retrieve districts for." />
		
		<cfset var districtObj =  do('District','getByZip',{ zip5 = ARGUMENTS.zip5, zip4 = ARGUMENTS.zip4 }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(districtObj,'error')>
			<cfset handleError(districtObj) />
		</cfif>
	
		<cfreturn districtObj />
	
	</cffunction>


	<!---                                             --->
	<!--- ELECTION CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Election.html --->
	<!---                                             --->

	
	<!--- GET ELECTION --->
	<cffunction name="getElection" access="public" output="false" returntype="struct" description="I implement the Election.getElection() method of the VoteSmart API. This method grabs district basic election data according to electionId.">
		<cfargument name="electionId" type="numeric" required="true" hint="I am the election id to retrieve election data for." />
		
		<cfset var electionObj =  do('Election','getElection',{ electionId = ARGUMENTS.electionId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(electionObj,'error')>
			<cfset handleError(electionObj) />
		</cfif>
	
		<cfreturn electionObj />
	
	</cffunction>
	
	<!--- GET ELECTIONS BY YEAR AND STATE --->
	<cffunction name="getElectionByYearState" access="public" output="false" returntype="struct" description="I implement the Election.getElectionByYearState() method of the VoteSmart API. This method grabs district basic election data according to year and stateid.">
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve elections for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve elections for." />
		
		<cfset var electionObj =  do('Election','getElectionByYearState',{ yearOf = ARGUMENTS.yearOf, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(electionObj,'error')>
			<cfset handleError(electionObj) />
		</cfif>
	
		<cfreturn electionObj />
	
	</cffunction>
	
	<!--- GET ELECTIONS BY ZIP --->
	<cffunction name="getElectionByZip" access="public" output="false" returntype="struct" description="I implement the Election.getElectionByZip() method of the VoteSmart API. This method grabs district basic election data according to zip code.">
		<cfargument name="zip5" type="string" required="true" hint="I am the 5 digit zip code to retrieve elections for." />
		<cfargument name="zip4" type="string" required="false" default="" hint="I am the +4 for the zip code to retrieve elections for." />
		<cfargument name="yearOf" type="numeric" required="false" default="" hint="I am the year to retrieve elections for." />
		
		<cfset var electionObj =  do('Election','getElectionByZip',{ zip5 = ARGUMENTS.zip5, zip4 = ARGUMENTS.zip4, yearOf = ARGUMENTS.yearOf }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(electionObj,'error')>
			<cfset handleError(electionObj) />
		</cfif>
	
		<cfreturn electionObj />
	
	</cffunction>
	
	<!--- GET ELECTION CANDIDATES BY STAGE --->
	<cffunction name="getElectionStageCandidates" access="public" output="false" returntype="struct" description="I implement the Election.getStageCandidates() method of the VoteSmart API. This method grabs district basic election data according to electionId and stageId. Per state lists of a Presidential election are available by specifying the stateId.">
		<cfargument name="electionId" type="numeric" required="true" hint="I am the election id to retrieve elections for." />
		<cfargument name="stageId" type="numeric" required="true" hint="I am the stage id to retrive elections for." />
		<cfargument name="party" type="string" required="false" default="" hint="I am the party to retrive elections for." />
		<cfargument name="districtId" type="numeric" required="false" default="" hint="I am the district id to retrieve elections for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrive elections for. " />
		
		<cfset var electionObj =  do('Election','getStageCandidates',{ electionId = ARGUMENTS.electionId, stageId = ARGUMENTS.stageId, party = ARGUMENTS.party, districtId = ARGUMENTS.districtId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(electionObj,'error')>
			<cfset handleError(electionObj) />
		</cfif>
	
		<cfreturn electionObj />
	
	</cffunction>
	

	<!---                                               --->
	<!--- LEADERSHIP CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Leadership.html --->
	<!---                                               --->

	
	<!--- GET LEADERSHIP POSITIONS --->
	<cffunction name="getLeadershipPositions" access="public" output="false" returntype="struct" description="I implement the Leadership.getPositions() method of the VoteSmart API. Gets leadership positions by state and office.">
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve positions for." />
		<cfargument name="officeId" type="numeric" required="false" default="" hint="I am the office id to retrieve positions for." />
		
		<cfset var leadershipObj =  do('Leadership','getPositions',{ stateId = ARGUMENTS.stateId, officeId = ARGUMENTS.officeId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(leadershipObj,'error')>
			<cfset handleError(leadershipObj) />
		</cfif>
	
		<cfreturn leadershipObj />
	
	</cffunction>
	
	<!--- GET LEADERSHIP OFFICIALS --->
	<cffunction name="getLeadershipOfficials" access="public" output="false" returntype="struct" description="I implement the Leadership.getOfficials() method of the VoteSmart API. Gets officials that hold the leadership role in certain states.">
		<cfargument name="leadershipId" type="numeric" required="false" default="" hint="I am the leadership id to retrieve officials for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve officials for." />
		
		<cfset var leadershipObj =  do('Leadership','getOfficials',{ leadershipId = ARGUMENTS.leadershipId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(leadershipObj,'error')>
			<cfset handleError(leadershipObj) />
		</cfif>
	
		<cfreturn leadershipObj />
	
	</cffunction>
	

	<!---                                          --->
	<!--- LOCAL CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Local.html --->
	<!---                                          --->

	
	<!--- GET LOCAL COUNTIES --->
	<cffunction name="getLocalCounties" access="public" output="false" returntype="struct" description="I implement the Local.getCounties() method of the VoteSmart API. Fetches counties in a state.">
		<cfargument name="stateId" type="numeric" required="true" hint="I am the state id to retrieve counties for." />
		
		<cfset var localObj =  do('Local','getCounties',{ stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(localObj,'error')>
			<cfset handleError(localObj) />
		</cfif>
	
		<cfreturn localObj />
	
	</cffunction>
	
	<!--- GET LOCAL CITIES --->
	<cffunction name="getLocalCities" access="public" output="false" returntype="struct" description="I implement the Local.getCities() method of the VoteSmart API. Fetches cities in a state.">
		<cfargument name="stateId" type="numeric" required="true" hint="I am the state id to retrieve cities for." />
		
		<cfset var localObj =  do('Local','getCities',{ stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(localObj,'error')>
			<cfset handleError(localObj) />
		</cfif>
	
		<cfreturn localObj />
	
	</cffunction>
	
	<!--- GET LOCAL OFFICIALS --->
	<cffunction name="getLocalOfficials" access="public" output="false" returntype="struct" description="I implement the Local.getOfficials() method of the VoteSmart API. Fetches officials for a locality.">
		<cfargument name="localId" type="numeric" required="true" hint="I am the local id to retrieve officials for." />
		
		<cfset var localObj =  do('Local','getOfficials',{ localId = ARGUMENTS.localId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(localObj,'error')>
			<cfset handleError(localObj) />
		</cfif>
	
		<cfreturn localObj />
	
	</cffunction>


	<!---                                         --->
	<!--- NPAT CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Npat.html --->
	<!---                                         --->

	
	<!--- GET NPAT/PCT --->
	<cffunction name="getNpat" access="public" output="false" returntype="struct" description="I implement the Npat.getNpat() method of the VoteSmart API. This method returns the candidates most recently filled out NPAT/PCT.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve NPAT/PCT results for." />
		
		<cfset var npatObj =  do('Npat','getNpat',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(npatObj,'error')>
			<cfset handleError(npatObj) />
		</cfif>
	
		<cfreturn npatObj />
	
	</cffunction>	
	

	<!---                                           --->
	<!--- OFFICE CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Office.html --->
	<!---                                           --->
		
		
	<!--- GET OFFICE TYPES --->
	<cffunction name="getOfficeTypes" access="public" output="false" returntype="struct" description="I implement the Office.getTypes() method of the VoteSmart API. This method dumps all office types we keep track of.">
		
		<cfset var officeObj =  do('Office','getTypes') />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>
		
	<!--- GET OFFICE BRANCHES --->
	<cffunction name="getOfficeBranches" access="public" output="false" returntype="struct" description="I implement the Office.getBranches() method of the VoteSmart API. This method dumps the branches of government and their IDs.">
		
		<cfset var officeObj =  do('Office','getBranches') />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>
		
	<!--- GET OFFICE LEVELS --->
	<cffunction name="getOfficeLevels" access="public" output="false" returntype="struct" description="I implement the Office.getLevels() method of the VoteSmart API. This method dumps the levels of government and their IDs.">
		
		<cfset var officeObj =  do('Office','getLevels') />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>
		
	<!--- GET OFFICES BY TYPE --->
	<cffunction name="getOfficesByType" access="public" output="false" returntype="struct" description="I implement the Office.getOfficesByType() method of the VoteSmart API. This method dumps offices we keep track of according to type.">
		<cfargument name="officeTypeId" type="numeric" required="true" hint="I am the office type id to retrieve offices for." />
		
		<cfset var officeObj =  do('Office','getOfficesByType',{ officeTypeId = ARGUMENTS.officeTypeId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>
		
	<!--- GET OFFICES BY LEVEL --->
	<cffunction name="getOfficesByLevel" access="public" output="false" returntype="struct" description="I implement the Office.getOfficesByLevel() method of the VoteSmart API. This method dumps offices we keep track of according to level.">
		<cfargument name="levelId" type="numeric" required="true" hint="I am the level id to retrieve offices for." />
		
		<cfset var officeObj =  do('Office','getOfficesByLevel',{ levelId = ARGUMENTS.levelId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>
		
	<!--- GET OFFICES BY TYPE AND LEVEL --->
	<cffunction name="getOfficesByTypeLevel" access="public" output="false" returntype="struct" description="I implement the Office.getOfficesByTypeLevel() method of the VoteSmart API. This method dumps offices we keep track of according to type and level.">
		<cfargument name="officeTypeId" type="numeric" required="true" hint="I am the office type id to retrieve offices for." />
		<cfargument name="officeLevelId" type="numeric" required="true" hint="I am the level id to retrieve offices for." />
		
		<cfset var officeObj =  do('Office','getOfficesByTypeLevel',{ officeTypeId = ARGUMENTS.officeTypeId, officeLevelId = ARGUMENTS.officeLevelId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>
		
	<!--- GET OFFICES BY BRANCH AND LEVEL --->
	<cffunction name="getOfficesByBranchLevel" access="public" output="false" returntype="struct" description="I implement the Office.getOfficesByBranchLevel() method of the VoteSmart API. This method dumps offices we keep track of according to branch and level.">
		<cfargument name="branchId" type="numeric" required="true" hint="I am the branch id to retrieve offices for." />
		<cfargument name="levelId" type="numeric" required="true" hint="I am the level id to retrieve offices for." />
		
		<cfset var officeObj =  do('Office','getOfficesByBranchLevel',{ branchId = ARGUMENTS.branchId, levelId = ARGUMENTS.levelId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officeObj,'error')>
			<cfset handleError(officeeObj) />
		</cfif>
	
		<cfreturn officeObj />
	
	</cffunction>

	
	<!---                                              --->
	<!--- OFFICIALS CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Officials.html --->
	<!---                                              --->	

	
	<!--- GET OFFICIALS STATEWIDE --->
	<cffunction name="getOfficialsStatewide" access="public" output="false" returntype="struct" description="I implement the Officials.getStatewide() method of the VoteSmart API. This method grabs a list of officials according to state representation.">
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getStatewide',{ stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>
	
	<!--- GET OFFICIALS BY OFFICE AND STATE --->
	<cffunction name="getOfficialsByOfficeState" access="public" output="false" returntype="struct" description="I implement the Officials.getByOfficeState() method of the VoteSmart API. This method grabs a list of officials according to office and state representation.">
		<cfargument name="officeId" type="numeric" required="true" hint="I am the officeid to retrieve officials for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getByOfficeState',{ officeId = ARGUMENTS.officeId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>
		
	<!--- GET OFFICIALS BY OFFICE TYPE AND STATE --->
	<cffunction name="getOfficialsByOfficeTypeState" access="public" output="false" returntype="struct" description="I implement the Officials.getByOfficeTypeState() method of the VoteSmart API. This method grabs a list of officials according to office type and state representation.">
		<cfargument name="officeTypeId" type="numeric" required="true" hint="I am the office type id to retrieve officials for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getByOfficeTypeState',{ officeTypeId = ARGUMENTS.officeTypeId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>	
	
	<!--- GET OFFICIALS BY LAST NAME --->
	<cffunction name="getOfficialsByLastname" access="public" output="false" returntype="struct" description="I implement the Officials.getByLastname() method of the VoteSmart API. This method grabs a list of officials according to a lastName match.">
		<cfargument name="lastName" type="string" required="true" hint="I am the last name to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getByLastname',{ lastName = ARGUMENTS.lastName }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>
	
	<!--- GET OFFICIALS BY FUZZY LAST NAME --->
	<cffunction name="getOfficialsByLevenshtein" access="public" output="false" returntype="struct" description="I implement the Officials.getByLevenshtein() method of the VoteSmart API. This method grabs a list of officials according to a fuzzy lastName match.">
		<cfargument name="lastName" type="string" required="true" hint="I am the last name to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getByLevenshtein',{ lastName = ARGUMENTS.lastName }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>
	
	<!--- GET OFFICIALS BY DISTRICT --->
	<cffunction name="getOfficialsByDistrict" access="public" output="false" returntype="struct" description="I implement the Officials.getByDistrict() method of the VoteSmart API. This method grabs a list of officials according to the district they are running for.">
		<cfargument name="districtId" type="string" required="true" hint="I am the district id to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getByDistrict',{ districtId = ARGUMENTS.districtId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>
	
	<!--- GET OFFICIALS BY ZIP --->
	<cffunction name="getOfficialsByZip" access="public" output="false" returntype="struct" description="I implement the Officials.getByZip() method of the VoteSmart API. This method grabs a list of officials according to the zip code they represent.">
		<cfargument name="zip5" type="string" required="true" hint="I am the 5 digit zip code to retrieve officials for." />
		<cfargument name="zip4" type="string" required="false" default="" hint="I am the +4 for the zip code to retrieve officials for." />
		
		<cfset var officialObj =  do('Officials','getByZip',{ zip5 = ARGUMENTS.zip5, zip4 = ARGUMENTS.zip4 }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(officialObj,'error')>
			<cfset handleError(officialObj) />
		</cfif>
	
		<cfreturn officialObj />
	
	</cffunction>	

	
	<!---                                           --->
	<!--- RATING CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Rating.html --->
	<!---                                           --->	

	
	<!--- GET RATING CATEGORIES --->
	<cffunction name="getRatingCategories" access="public" output="false" returntype="struct" description="I implement the Rating.getCategories() method of the VoteSmart API. This method dumps categories that contain released ratings according to state.">
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve rating categories for." />
		
		<cfset var ratingObj =  do('Rating','getCategories',{ stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(ratingObj,'error')>
			<cfset handleError(ratingObj) />
		</cfif>
	
		<cfreturn ratingObj />
	
	</cffunction>
	
	<!--- GET RATING SPECIAL INTEREST GROUP LIST --->
	<cffunction name="getRatingSigList" access="public" output="false" returntype="struct" description="I implement the Rating.getSigList() method of the VoteSmart API. This method dumps Special Interest Groups according to category and state.">
		<cfargument name="categoryId" type="numeric" required="true" hint="I am the category id to retrieve special interest groups for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve special interest groups for." />
		
		<cfset var ratingObj =  do('Rating','getSigList',{ categoryId = ARGUMENTS.categoryId, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(ratingObj,'error')>
			<cfset handleError(ratingObj) />
		</cfif>
	
		<cfreturn ratingObj />
	
	</cffunction>
	
	<!--- GET RATING SPECIAL INTEREST GROUP DETAILS --->
	<cffunction name="getRatingSig" access="public" output="false" returntype="struct" description="I implement the Rating.getSig() method of the VoteSmart API. This method dumps detailed information an a Special Interest Group.">
		<cfargument name="sigId" type="numeric" required="true" hint="I am the special interest group id to retrieve special interest group details for." />
		
		<cfset var ratingObj =  do('Rating','getSig',{ sigId = ARGUMENTS.sigId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(ratingObj,'error')>
			<cfset handleError(ratingObj) />
		</cfif>
	
		<cfreturn ratingObj />
	
	</cffunction>
	
	<!--- GET RATING SPECIAL INTEREST GROUP RATINGS --->
	<cffunction name="getRatingSigRatings" access="public" output="false" returntype="struct" description="I implement the Rating.getSigRatings() method of the VoteSmart API. This method dumps all ratings(scorecards) by a Special Interest Group.">
		<cfargument name="sigId" type="numeric" required="true" hint="I am the special interest group id to retrieve special interest group ratings for." />
		
		<cfset var ratingObj =  do('Rating','getSigRatings',{ sigId = ARGUMENTS.sigId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(ratingObj,'error')>
			<cfset handleError(ratingObj) />
		</cfif>
	
		<cfreturn ratingObj />
	
	</cffunction>
	
	<!--- GET RATING SPECIAL INTEREST GROUP CANDIDATE RATING --->
	<cffunction name="getRatingCandidateRating" access="public" output="false" returntype="struct" description="I implement the Rating.getCandidateRating() method of the VoteSmart API. This method dumps a candidate's rating by an SIG.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve special interest group ratings for." />
		<cfargument name="sigId" type="numeric" required="false" default="" hint="I am the special interest group id to retrieve special interest group ratings for." />
		
		<cfset var ratingObj =  do('Rating','getCandidateRating',{ candidateId = ARGUMENTS.candidateId, sigId = ARGUMENTS.sigId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(ratingObj,'error')>
			<cfset handleError(ratingObj) />
		</cfif>
	
		<cfreturn ratingObj />
	
	</cffunction>
	
	<!--- GET RATING SPECIAL INTEREST GROUP RATING --->
	<cffunction name="getRating" access="public" output="false" returntype="struct" description="I implement the Rating.getRating() method of the VoteSmart API. This method dumps all candidate ratings from a scorecard by an SIG.">
		<cfargument name="ratingId" type="numeric" required="true" hint="I am the rating id to retrieve special interest group rating details for." />
		
		<cfset var ratingObj =  do('Rating','getRating',{ ratingId = ARGUMENTS.ratingId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(ratingObj,'error')>
			<cfset handleError(ratingObj) />
		</cfif>
	
		<cfreturn ratingObj />
	
	</cffunction>

	
	<!---                                          --->
	<!--- STATE CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/State.html --->
	<!---                                          --->	

	
	<!--- GET STATE ID'S --->
	<cffunction name="getStateIDs" access="public" output="false" returntype="struct" description="I implement the State.getStateIDs() method of the VoteSmart API. This method grabs a simple state ID and name list for mapping ID to state names.">
		
		<cfset var stateObj =  do('State','getStateIDs') />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(stateObj,'error')>
			<cfset handleError(stateObj) />
		</cfif>
	
		<cfreturn stateObj />
	
	</cffunction>
	
	<!--- GET STATE --->
	<cffunction name="getState" access="public" output="false" returntype="struct" description="I implement the State.getState() method of the VoteSmart API. This method grabs a various data we keep on a state.">
		<cfargument name="stateId" type="numeric" required="true" hint="I am the state id to retrieve state details for." />
		
		<cfset var stateObj =  do('State','getState',{ stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(stateObj,'error')>
			<cfset handleError(stateObj) />
		</cfif>
	
		<cfreturn stateObj />
	
	</cffunction>

	
	<!---                                          --->
	<!--- VOTES CLASS SECTION                      --->
	<!--- http://api.votesmart.org/docs/Votes.html --->
	<!---                                          --->	

	
	<!--- GET VOTE CATEGORIES --->
	<cffunction name="getVoteCategories" access="public" output="false" returntype="struct" description="I implement the Votes.getCategories() method of the VoteSmart API. This method dumps categories that contain released bills according to year and state.">
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve vote categories for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve vote categories for." />
		
		<cfset var voteObj =  do('Votes','getCategories',{ yearOf = ARGUMENTS.yearOf, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET VOTE BILL --->
	<cffunction name="getVoteBill" access="public" output="false" returntype="struct" description="I implement the Votes.getBill() method of the VoteSmart API. This method dumps general information on a bill.">
		<cfargument name="billId" type="numeric" required="true" hint="I am the bill id to retrieve votes for." />
		
		<cfset var voteObj =  do('Votes','getBill',{ billId = ARGUMENTS.billId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET VOTE BILL ACTION --->
	<cffunction name="getVoteBillAction" access="public" output="false" returntype="struct" description="I implement the Votes.getBillAction() method of the VoteSmart API. This gets detailed action information on a certain stage of the bill.">
		<cfargument name="actionId" type="numeric" required="true" hint="I am the sction id to retrieve vote action details for." />
		
		<cfset var voteObj =  do('Votes','getBillAction',{ actionId = ARGUMENTS.actionId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET VOTE BILL ACTION VOTES --->
	<cffunction name="getBillActionVotes" access="public" output="false" returntype="struct" description="I implement the Votes.getBillActionVotes() method of the VoteSmart API. Method provides votes listed by candidate on a certain bill action.">
		<cfargument name="actionId" type="numeric" required="true" hint="I am the sction id to retrieve vote action details for." />
		
		<cfset var voteObj =  do('Votes','getBillActionVotes',{ actionId = ARGUMENTS.actionId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET VOTE BILL ACTION VOTES --->
	<cffunction name="getBillActionVoteByOfficial" access="public" output="false" returntype="struct" description="I implement the Votes.getBillActionVoteByOfficial() method of the VoteSmart API. Returns a single vote according to official and action.">
		<cfargument name="actionId" type="numeric" required="true" hint="I am the sction id to retrieve vote action details for." />
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve vote action details for." />
		
		<cfset var voteObj =  do('Votes','getBillActionVoteByOfficial',{ actionId = ARGUMENTS.actionId, candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET VOTES BY BILL NUMBER --->
	<cffunction name="getVotesByBillNumber" access="public" output="false" returntype="struct" description="I implement the Votes.getByBillNumber() method of the VoteSmart API. Returns a list of bills that are like the billNumber input.">
		<cfargument name="billNumber" type="string" required="true" hint="I am the bill number to retrieve vote action details for." />
		
		<cfset var voteObj =  do('Votes','getByBillNumber',{ billNumber = ARGUMENTS.billNumber }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILLS BY CATEGORY, YEAR AND STATE --->
	<cffunction name="getBillsByCategoryYearState" access="public" output="false" returntype="struct" description="I implement the Votes.getBillsByCategoryYearState() method of the VoteSmart API. Returns a list of bills that fit the category, year, and state input.">
		<cfargument name="categoryId" type="string" required="true" hint="I am the category id to retrieve bill details for." />
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve bill details for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve bill details for." />
		
		<cfset var voteObj =  do('Votes','getBillsByCategoryYearState',{ categoryId = ARGUMENTS.categoryId, yearOf = ARGUMENTS.yearOf, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILLS BY YEAR AND STATE --->
	<cffunction name="getBillsByYearState" access="public" output="false" returntype="struct" description="I implement the Votes.getBillsByYearState() method of the VoteSmart API. Returns a list of bills that fit the year and state input.">
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve bill details for." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve bill details for." />
		
		<cfset var voteObj =  do('Votes','getBillsByYearState',{ yearOf = ARGUMENTS.yearOf, stateId = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILL BY OFFICIAL, YEAR AND OFFICE --->
	<cffunction name="getBillsByOfficialYearOffice" access="public" output="false" returntype="struct" description="I implement the Votes.getBillsByOfficialYearOffice() method of the VoteSmart API. Returns a list of bills that fit the candidate and year.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve vote action details for." />
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve bill details for." />
		<cfargument name="officeId" type="numeric" required="false" default="" hint="I am the office id to retrive bill details for." />
		
		<cfset var voteObj =  do('Votes','getBillsByOfficialYearOffice',{ candidateId = ARGUMENTS.candidateId, yearOf = ARGUMENTS.yearOf, officeId = ARGUMENTS.officeId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILL BY OFFICIAL, CATEGORY AND OFFICE --->
	<cffunction name="getBillsByOfficialCategoryOffice" access="public" output="false" returntype="struct" description="I implement the Votes.getBillsByOfficialCategoryOffice() method of the VoteSmart API. Returns a list of bills that fit the candidate and category.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve vote action details for." />
		<cfargument name="categoryId" type="numeric" required="true" hint="I am the category id to retrieve bill details for." />
		<cfargument name="officeId" type="numeric" required="false" default="" hint="I am the office id to retrive bill details for." />
		
		<cfset var voteObj =  do('Votes','getBillsByOfficialCategoryOffice',{ candidateId = ARGUMENTS.candidateId, categoryId = ARGUMENTS.categoryId, officeId = ARGUMENTS.officeId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILLS BY OFFICIAL --->
	<cffunction name="getBillsByOfficial" access="public" output="false" returntype="struct" description="I implement the Votes.getByOfficial() method of the VoteSmart API. This method dumps all the bills an official has voted on based on the candidateId, officeId, categoryId, and year.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve bills for." />
		<cfargument name="officeId" type="numeric" required="false" default="" hint="I am the office id to retrive bills for." />
		<cfargument name="categoryId" type="numeric" required="false" default="" hint="I am the category id to retrieve bills for." />
		<cfargument name="yearOf" type="numeric" required="false" default="" hint="I am the year to retrieve bills for." />
		
		<cfset var voteObj =  do('Votes','getByOfficial',{ candidateId = ARGUMENTS.candidateId, officeId = ARGUMENTS.officeId, categoryId = ARGUMENTS.categoryId, yearOf = ARGUMENTS.yearOf }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILLS BY SPONSOR AND YEAR --->
	<cffunction name="getBillsBySponsorYear" access="public" output="false" returntype="struct" description="I implement the Votes.getBillsBySponsorYear() method of the VoteSmart API. Returns a list of bills that fit the sponsor's candidateId and year.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve bills for." />
		<cfargument name="yearOf" type="numeric" required="true" hint="I am the year to retrieve bills for." />
		
		<cfset var voteObj =  do('Votes','getBillsBySponsorYear',{ candidateId = ARGUMENTS.candidateId, yearOf = ARGUMENTS.yearOf }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET BILLS BY SPONSOR AND CATEGORY --->
	<cffunction name="getBillsBySponsorCategory" access="public" output="false" returntype="struct" description="I implement the Votes.getByOfficial() method of the VoteSmart API. Returns a list of bills that fit the sponsor's candidateId and category.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve bills for." />
		<cfargument name="categoryId" type="numeric" required="true" hint="I am the category id to retrieve bills for." />
		
		<cfset var voteObj =  do('Votes','getByOfficial',{ candidateId = ARGUMENTS.candidateId, categoryId = ARGUMENTS.categoryId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET RECENT STATE BILLS --->
	<cffunction name="getBillsByStateRecent" access="public" output="false" returntype="struct" description="I implement the Votes.getBillsByStateRecent() method of the VoteSmart API. Returns a list of recent bills according to the state. Max returned is 100 or however much less you want.">
		<cfargument name="amount" type="numeric" required="false" default="100" hint="I am the amount of records to return. Max: 100." />
		<cfargument name="stateId" type="numeric" required="false" default="" hint="I am the state id to retrieve bills for." />
		
		<cfset var voteObj =  do('Votes','getBillsByStateRecent',{ amount = ARGUMENTS.amount, state = ARGUMENTS.stateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	
	<!--- GET VETOS BY CANDIDATE --->
	<cffunction name="getVetoes" access="public" output="false" returntype="struct" description="I implement the Votes.getVetoes() method of the VoteSmart API. Returns a list of vetoes according to candidate.">
		<cfargument name="candidateId" type="numeric" required="true" hint="I am the candidate id to retrieve bills for." />
		
		<cfset var voteObj =  do('Votes','getVetoes',{ candidateId = ARGUMENTS.candidateId }) />
		
		<!--- check if an error occurred processing this request --->
		<cfif StructKeyExists(voteObj,'error')>
			<cfset handleError(voteObj) />
		</cfif>
	
		<cfreturn voteObj />
	
	</cffunction>
	

	<!---                   --->
	<!--- PRIVATE FUNCTIONS --->
	<!---                   --->

	
	<!--- DO API CALL --->	
	<cffunction name="do" access="private" output="false" returntype="any" description="I am the main method of the VoteSmart API. I should be called for all operations.">
		<cfargument name="class" type="string" required="true" hint="I am the VoteSmart class to call. Address, for example." />
		<cfargument name="method" type="string" required="true" hint="I am the method of the VoteSmart class to call. getCampaign, for example." />
		<cfargument name="args" type="struct" required="false" hint="I am a struct of the arguments to pass to the VoteSmart API." />
		
		<!--- var scope --->
		<cfset var httpResult = "">
		<cfset var arg = "">
		<!--- set up error data to return in the event of an error --->
		<cfset var errData = { 
			class = ARGUMENTS.class, 
			method = ARGUMENTS.method, 
			args = ARGUMENTS.args, 
			date = DateFormat(Now(),'mm.dd.yyyy'), 
			time = TimeFormat(Now(),'hh:mm:ss tt') 
		} />
		
		<!--- try the API call --->		
		<cftry>
		
			<!--- call the API with the class, method and arguments provided --->
			<cfhttp url="#variables.instances.apiUrl##ARGUMENTS.class#.#ARGUMENTS.method#" result="httpResult" handleError="yes" useragent="cfVoteSmart [github.com/teamcfadvance/cfVoteSmart]" timeout="900" charset="utf-8">
			
				<!--- set the api key as a URL variable --->
				<cfhttpparam type="url" name="key" value="#variables.instance.apiKey#" />
				<!--- set the output format (o) as a URL variable --->
				<cfhttpparam type="url" name="o" value="#variables.instance.format#" />
				
				<!--- check if there are arguments to parse --->
				<cfif IsStruct(ARGUMENTS.args) AND NOT StructIsEmpty(ARGUMENTS.args)>
					<!--- loop through arguments --->
					<cfloop collection="#ARGUMENTS.args#" index="arg">
						<!--- check if this argument has length --->
						<cfif Len(ARGUMENTS.args[arg])>
							<!--- check if this arg equals 'yearOf' --->
							<cfif FindNoCase('yearOf',arg)>
								<!--- is does, set the URL param to 'year' instead of 'yearOf' --->
								<cfhttpparam type="url" name="year" value="#ARGUMENTS.args[arg]#" />
							<!--- otherwise --->
							<cfelse>
								<!--- it doesn't, set the arg as the URL param --->
								<cfhttpparam type="url" name="#arg#" value="#ARGUMENTS.args[arg]#" />
							<!--- end checking if this arg equals 'yearOf' --->
							</cfif>
						<!--- end checking if this argument has length --->	
						</cfif>
					<!--- end looping through arguments --->
					</cfloop>
				<!--- end checking if there are arguments to parse --->
				</cfif>
				 
			</cfhttp>
			
			<!--- check if the requested format is JSON and if the result returned by the API is valid JSON data --->
			<cfif FindNoCase('json',variables.instance.format) AND IsJSON(httpResult.fileContent)>
				<!--- it is, return the deserailized struct --->
				<cfreturn DeserializeJSON(httpResult.fileContent) />
			<!--- otherwise, check if the requested format is XML and if the result returned by the API is valid XML text --->
			<cfelseif FindNoCase('xml',variables.instance.format) AND IsXML(httpResult.fileContent)>
				<!--- it is, return the parsed struct --->
				<cfreturn XMlParse(httpResult.fileContent) />
			<!--- otherwise --->
			<cfelse>
				<!--- the format requested and/or the result returned is not one of JSON or XML, set some diagnostic data --->
				<cfset diag = { format = variables.instance.format, isValidJSON = IsJSON(httpResult.fileContent), isValidXML = IsXML(httpResult.fileContent) } />
				<!--- and return the error data, httpResult and diagnostic information (caught by error handler) --->
				<cfreturn { error = errData, httpResult = httpResult, diagnostics = diag } />
			</cfif>
		
		<!--- catch any errors --->
		<cfcatch type="any">
			
			<!--- check if httpResult is defined and is a structure --->
			<cfif IsDefined('httpResult') AND IsStruct(httpResult) />
				<!--- it is, return the error data, the cfcatch struct and the httpResult struct (as a struct) --->
				<cfreturn { error = errData, cfcatch = cfcatch, httpResult = httpResult } />
			<!--- otherwise --->
			<cfelse>
				<!--- it isn't, send only the error data and cfcatch struct (as a struct) --->
				<cfreturn { error = errData, cfcatch = cfcatch } />
			</cfif>
		</cfcatch>
		</cftry>
		
	</cffunction>
	
	<!--- HANDLE ERRORS --->
	<cffunction name="handleError" access="private" output="true" returntype="void" description="I am a generic handler for returning error information.">
		<cfargument name="errorObj" type="any" required="true" hint="I am the error structure returned from the API call (do)." />
		
		<cfset var errDetail = '' />
		
		<!--- check if the debug level is 'log' or 'throwlog' --->
		<cfif FindNoCase('log',variables.instance.debug) OR FindNoCase('throwlog',variables.instance.debug)>
			
			<!--- it is, save the TEXT error details dump --->	
			<cfsavecontent variable="errDetail">
				<cfdump var="#ARGUMENTS.errorObj#" format="text">
			</cfsavecontent>
			<!--- and log the error --->
			<cflog text="#errDetail#" type="Error" file="#variables.instance.logFile#" thread="yes" date="yes" time="yes" application="yes" />
		
		</cfif>
		
		<!--- check if the debug level is 'throw' or 'throwlog' --->
		<cfif FindNoCase('throw',variables.instance.debug) OR FindNoCase('throwlog',variables.instance.debug)>
			
			<!--- it is, save the HTML error details dump --->	
			<cfsavecontent variable="errDetail">
				<cfdump var="#ARGUMENTS.errorObj#">
			</cfsavecontent>
			<!--- and throw an error --->
			<cfthrow message="API Processing Error" type="error" detail="#errDetail#" errorcode="400" />
		
		</cfif>
				
	</cffunction>
	
</cfcomponent>