</div>
<footer class="footer text-right" style="margin-top: 20px;"> © 2017. All rights reserved. </footer>
<!-- <div class="page-loader">
	<a href="#"><img src="catalog/view/theme/default/assets/images/logo-2.png" class="img-responsive center-block" alt=""/></a>
	<span class="text-uppercase">Loading...</span>
</div> -->

<!-- Odoo Js files --> 
<script>
       var resizefunc = [];
</script> 

 
<script src="catalog/view/theme/default/assets/js/pace.min.js"></script> 
<script src="catalog/view/theme/default/assets/js/loader.js"></script> 
<script src="catalog/view/theme/default/assets/js/detect.js"></script> 
<script src="catalog/view/theme/default/assets/js/fastclick.js"></script> 
<script src="catalog/view/theme/default/assets/js/waves.js"></script> 
<script src="catalog/view/theme/default/assets/js/wow.min.js"></script> 
<script src="catalog/view/theme/default/assets/js/jquery.slimscroll.js"></script> 
<script src="catalog/view/theme/default/assets/js/jquery.nicescroll.js"></script> 
<script src="catalog/view/theme/default/assets/js/jquery.scrollTo.min.js"></script> 

<script src="catalog/view/theme/default/assets/js/jquery.app.js"></script> 


    <script type="text/javascript">
     $("#MemberUserName").keyup(function(){
            $.ajax({
            type: "POST",
            url: "<?php echo HTTPS_SERVER ?>getaccount",
            data:'keyword='+$(this).val(),        
            success: function(data){
                $("#suggesstion-box").show();
                $("#suggesstion-box").html(data);
                $("#MemberUserName").css("background","#FFF");            
            }
            });
        });
function selectU(val) {
        $("#MemberUserName").val(val);
        $("#suggesstion-box").hide();
    }
var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

$('.js-textareacopybtn').click(function(event) {
  var copyTextarea = document.querySelector('.js-copytextarea');
  copyTextarea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }
});
        </script>

   <script type="text/javascript">


   	$('.packet-invest').on('submit', function(){
   		var self = $(this);
      var root = "https://blockchain.info/";
   		alertify.confirm('<p class="text-center" style="font-size:25px;color: black;text-transform: uppercase;height: 40px">You make sure your choice !</p>',
		  function(){
		    window.funLazyLoad.start();
	   		setTimeout(function(){
				self.ajaxSubmit({
					success : function(result) {
						result = $.parseJSON(result);
						
						var amount = result.amount / 100000000;
						var package = result.package;
						if(_.has(result, 'btn') && result['btn'] === 1){
              var html = '<button id="payment_o" class="btn btn-info">Pay with O Wallet</button>';
            }else{
              var html ='';
            }  
						var xhtml = '<div class="col-md-12">Please send '+amount+' BTC to this address.</div><div class="col-md-6"><img style="margin-left:0px" src="https://chart.googleapis.com/chart?chs=225x225&chld=L|0&cht=qr&chl=bitcoin:'+result.input_address+'?amount='+amount+'"/><p>'+result.input_address+'</p></div><div class="col-md-6"><p>Your Packet: '+package+' USD</p>Total: '+ amount +' BTC</p> <p><code><h4>O Wallet: '+result.o_wallet+' USD</h4></code></p><p>'+html+'</p></div>';
						alertify.alert(xhtml, function(){                

						    window.funLazyLoad.reset();
						    
							    location.reload(true);
						    
						  });
         payment_o(result.my_wallet, result.invest, result.invoice);
						function checkBalance() {
                            $.ajax({
                                type: "GET",
                                url: root + 'q/getreceivedbyaddress/'+result.input_address,
                                data : {format : 'plain'},
                                success: function(response) {

                                    if (!response) return;

                                    var value = parseInt(response);

                                    if (value > 0) {
                                        var xhtml = '<div class="col-md-12 text-center"><h3>Payment success!</h3></div>';
                                        alertify.alert(xhtml, function(){
                    												window.funLazyLoad.reset();
                    										    	location.reload(true);
                    										 });
                                    } else {
                                        setTimeout(checkBalance, 5000);
                                    }
                                }
                            });
                        }
                    setTimeout(checkBalance, 5000);
						
					}
				});
				// check_payment();
			}, 200);
		  },
		  function(){
		});
   		return false;
   	});
function payment_o(mywallet, invest, invoice) {
    $('#payment_o').click(function() {
        alertify.confirm('<p class="text-center" style="font-size:25px;color: black;text-transform: ;height: 20px">Are you sure?</p>', function(e) {
            if (e) {
                var Wallet = mywallet;
                $.ajax({
                    type: "POST",
                    url: "<?php echo HTTPS_SERVER ?>callback_pd_wallet",
                    data: 'wallet=' + Wallet + '&invest=' + invest + '&invoice=' + invoice,
                    success: function(response) {
                        if (!response) return;
                        response = $.parseJSON(response);
                        if (response.ok_callback == 1) {
                            var xhtml = '<div class="col-md-12 text-center"><h3>Payment success!</h3></div>';
                             alertify.alert(xhtml, function() {
                                 window.funLazyLoad.reset();
                                 location.reload(true);
                             });
                        }
                    }
                });

            } else {
                return false;
            }
        });
    });
}
   	$('.packet-invoide').on('submit', function(){
 		var root = "https://blockchain.info/";
   		var self = $(this);
	    window.funLazyLoad.start();
   		setTimeout(function(){
			self.ajaxSubmit({
				success : function(result) {

					result = $.parseJSON(result);
					
					if(_.has(result, 'success') && result['success'] === 1){
						var xhtml = '<div class="col-md-12 text-center"><h3>You have to activate this package! please select another package!</h3></div>'
					}else{
						var amount = result.amount / 100000000;
						if(_.has(result, 'btn') && result['btn'] === 1){
              var html = '<button id="payment_o" class="btn btn-info">Pay with O Wallet</button>';
            }else{
              var html ='';
            }  
						var package = result.package;
						var total = amount;
						var received = result.received / 100000000;
						var xhtml = '<div class="col-md-12">Please send '+amount+' BTC to this address.</div><div class="col-md-6"><img style="margin-left:-10px" src="https://chart.googleapis.com/chart?chs=225x225&chld=L|0&cht=qr&chl=bitcoin:'+result.input_address+'?amount='+amount+'"/><p>'+result.input_address+'</p></div><div class="col-md-6"><p>Your Packet: '+package+' USD</p><p>Total: '+ total +' BTC</p><p></p>Paid amount: '+received+' BTC <p><code><h4>O Wallet: '+result.o_wallet+' USD</h4></code></p><p>'+html+'</p></div>';
						}
					
					alertify.alert(xhtml, function(){
              

							window.funLazyLoad.reset();
					    	location.reload(true);
					 });
          payment_o(result.my_wallet, result.invest, result.invoice);
					function checkBalance() {
                            $.ajax({
                                type: "GET",
                                url: root + 'q/getreceivedbyaddress/'+result.input_address,
                                data : {format : 'plain'},
                                success: function(response) {

                                    if (!response) return;

                                    var value = parseInt(response);

                                    if (value > 0) {
                                        var xhtml = '<div class="col-md-12 text-center"><h3>Payment success!</h3></div>';
                                        alertify.alert(xhtml, function(){
                									 		 	window.funLazyLoad.reset();
                										    	location.reload(true);
                										 });  
                                    } else {
                                        setTimeout(checkBalance, 5000);
                                    }
                                }
                            });
                        }
                    setTimeout(checkBalance, 5000);
				}
			});
		
		}, 200);
   		return false;
   	});
	
   </script>
  
   
</body>
</html>