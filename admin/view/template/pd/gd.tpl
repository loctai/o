<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
<div class="page-header">
  <div class="container-fluid">
    <h1>List Withdrawal Success</h1>

  </div>
</div>
<div class="container-fluid">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title pull-left">List Withdrawal Success </h3>
      
      <div class="clearfix">
          
      </div>
    </div>
    <div class="panel-body row">
        <div class="clearfix" style="margin-top:10px;"></div>
     	<table class="table table-bordered table-hover">
     		<thead>
     			<tr>
     				<th>TT</th>
     				<th>Username</th>
            <th>Wallet</th>
            <th>USD</th>
            <th>BTC</th>  
            <th>Date</th>
            <th>TX</th>
     			</tr>
     		</thead>
     		<tbody>
        <?php 
          $i = 0;
          //print_r($_SESSION); die;
          foreach ($code as $value) {
           
            $i++;
        ?>
          <tr>
            <td><?php echo $i; ?></td>
            <td><?php echo $self -> get_username($value['customer_id']) ?></td>
            <td><a target="_blank" href="https://blockchain.info/address/<?php echo $value['wallet'] ?>"><?php echo $value['wallet'] ?> <i class="fa fa-external-link" aria-hidden="true"></i></a></td>
            <td><?php echo $value['filled'] ?> USD</td>
            <td><?php echo $value['amount'] ?> BTC</td>
            <td><?php echo date('d/m/Y',strtotime($value['date_added'])); ?></td>
            <td><span class="label label-success" style="color: #fff"><?php echo $value['tx']; ?></span></td>
            
          </tr>
         <?php
          }
         ?>
     		</tbody>
     	</table>
      <?php echo $pagination; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>