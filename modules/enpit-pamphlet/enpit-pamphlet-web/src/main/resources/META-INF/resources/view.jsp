<%@ include file="/init.jsp" %>





<div class="container">

	<p>
		<b><liferay-ui:message key="enpitpamphletweb.caption"/></b>
	</p>

	<div class = "root">
		<img src="<%= request.getContextPath() %>/image/uma_Map.png" class="map">
		<div class="aui_popup_click1">
			<img src="<%= request.getContextPath() %>/image/baba.png" class="baba location-image-button">
		</div>
		<div class="aui_popup_click2">
			<img src="<%= request.getContextPath() %>/image/hikiUma.png" class="hikiUma location-image-button">
		</div>
		<div class="aui_popup_click3">
			<img src="<%= request.getContextPath() %>/image/car.png" class="car location-image-button">
		</div>
		<div class="aui_popup_click4">
			<img src="<%= request.getContextPath() %>/image/forest.jpg" class="forest location-image-button">
		</div>
	
		<div id="aui_popup_content1" >
		</div>
	
		<div id="aui_popup_content2" >
		</div>
	
		<div id="aui_popup_content3" >
		</div>
	
		<div id="aui_popup_content4" >
		</div>
	</div>
	<div>
		<aui:script use="aui-modal,aui-overlay-manager">
			A.one("#aui_popup_click1").on('click',function(event){
				var dialog = new A.Modal({
					title: "AUI Popup",
					bodyContent: 'AUI Modal1',
					headerContent: 'Modal header1',
					centered: true,
					modal: true,
					height: 520,
					render: '#aui_popup_content1',
					close: true
				});
				dialog.render();
			});
		</aui:script>
	
		<aui:script use="aui-modal,aui-overlay-manager">
			A.one("#aui_popup_click2").on('click',function(event){
				var dialog = new A.Modal({
					title: "AUI Popup",
					bodyContent: 'AUI Modal2',
					headerContent: 'Modal header2',
					centered: true,
					modal: true,
					height: 520,
					render: '#aui_popup_content2',
					close: true
				});
				dialog.render();
			});
		</aui:script>
	
		<aui:script use="aui-modal,aui-overlay-manager">
			A.one("#aui_popup_click3").on('click',function(event){
				var dialog = new A.Modal({
					title: "AUI Popup",
					bodyContent: 'AUI Modal3',
					headerContent: 'Modal header3',
					centered: true,
					modal: true,
					height: 520,
					render: '#aui_popup_content3',
					close: true
				});
				dialog.render();
			});
		</aui:script>
		
		<aui:script use="aui-modal,aui-overlay-manager">
			A.one("#aui_popup_click4").on('click',function(event){
				var dialog = new A.Modal({
					title: "AUI Popup",
					bodyContent: 'AUI Modal4',
					headerContent: 'Modal header4',
					centered: true,
					modal: true,
					height: 520,
					render: '#aui_popup_content4',
					close: true
				});
				dialog.render();
			});
		</aui:script>
	</div>
	<div class="scroll">
		<div class="ux-contents" id="share-comment-view">
		</div>
	</div>
	
			
		
	<div class="form-group">
		<input class="form-control" id="basicInputTypeText" placeholder="Please Enter a Content" type="text">
		<button class="btn send-button" type="button">Send</button>
	</div>

</div>

<aui:script>
	document.addEventListener('DOMContentLoaded', () => {	
		var locationId = null
		const sendBtnElm = document.querySelector(".btn.send-button")
		const textElm = document.querySelector("#basicInputTypeText")
		const shareCommentViewElm = document.getElementById('share-comment-view')
		const locationImageButtonElmArray = document.querySelectorAll('.location-image-button')
		
		locationImageButtonElmArray.forEach((elm, ind) => {
			elm.addEventListener("click", () => {
				locationId = ind + 1
				
				Liferay.Service(
				  '/pamphlet.pamphlet/get-pamphlets',
				  {
				    locationId: locationId,
				    start: -1,
				    end: -1
				  },
				  obj => {
				  	console.log(obj)
				  	
				  	obj.sort((a, b) => b.createDate - a.createDate)
				  	
				  	let htmlTemplate = ''				  	
				  	obj.forEach(e => {
					    const recieveData = e
					    const translateTimestamp = (() => {
					    	console.log(recieveData.createDate)
		                    
		                    var intTime = recieveData.createDate
		                    var d = new Date( intTime );
						    var year  = d.getFullYear();
						
						    var month = d.getMonth() + 1;
						    var day  = d.getDate();
						    var hour = ( '0' + d.getHours() ).slice(-2);
						    var min  = ( '0' + d.getMinutes() ).slice(-2);
						    var sec   = ( '0' + d.getSeconds() ).slice(-2);
						
						    return( year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec );
						})()
					    
					    htmlTemplate += '<div class="share">'
					    htmlTemplate += '<p class="name">' + recieveData.userName + '</p>'
					    htmlTemplate += '<p class="comment">' + recieveData.content + '</p>'
					    htmlTemplate += '<p class="timestamp">' + translateTimestamp + '</p>'
					    htmlTemplate += '</div>'				  	
				  	})
				  	
				  	shareCommentViewElm.innerHTML = htmlTemplate
				  }
				);
			})		
		})
		
		sendBtnElm.addEventListener("click", () => {
			if (locationId === null) {
				alert("クリックしていません")
			}
			
			else {
				Liferay.Service(
				  '/pamphlet.pamphlet/add-entry',
				  {
				    locationId: locationId,
				    content: textElm.value
				  },
				  obj => {
				    const recieveData = obj
				    const translateTimestamp = (() => {
				    	console.log(recieveData.createDate)
	                    
	                    var intTime = recieveData.createDate
	                    var d = new Date( intTime );
					    var year  = d.getFullYear();
					
					    var month = d.getMonth() + 1;
					    var day  = d.getDate();
					    var hour = ( '0' + d.getHours() ).slice(-2);
					    var min  = ( '0' + d.getMinutes() ).slice(-2);
					    var sec   = ( '0' + d.getSeconds() ).slice(-2);
					
					    return( year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec );
					})()
				    
				    let htmlTemplate = '<div class="share">'
				    htmlTemplate += '<p class="name">' + recieveData.userName + '</p>'
				    htmlTemplate += '<p class="comment">' + recieveData.content + '</p>'
				    htmlTemplate += '<p class="timestamp">' + translateTimestamp + '</p>'
				    htmlTemplate += '</div>'
				    
				    shareCommentViewElm.innerHTML = htmlTemplate + shareCommentViewElm.innerHTML.toString()
				  }
				);
			}
		}); 	
	})
</aui:script>	
