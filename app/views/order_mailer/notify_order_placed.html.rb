<style media="screen">
   body {
       font: 12px/150% Arial,Verdana,"\5b8b\4f53";
       color: #666;
       background: #fff;
   }
 </style>
 <div class="row">
   <div class="col-md-12">

     <h4> 订单明细 </h4>

     <table class="table table-bordered">
       <thead>
         <tr>
           <th width="80%">商品明细</th>
           <th>单价</th>
         </tr>
       </thead>
       <tbody>

         <% @product_lists.each do |product_list| %>
           <tr>
             <td>
               <%= product_list.product_name %>
             </td>
             <td>
               <%= product_list.product_price %>
             </td>
           </tr>
         <% end %>

       </tbody>
     </table>

     <div class="total clearfix">
       <span class="pull-right">
         总计 <%= @order.total %> RMB
       </span>
     </div>

      <hr>

      <h4> 寄送信息 </h4>

      <table class="table table-striped table-bordered">
       <tbody>
         <tr>
           <td>
             订购人
           </td>
         </tr>
         <tr>
           <td>
             <%= @order.billing_name %> - <%= @order.billing_address %>
           </td>
         </tr>
          <tr>
           <td>
             收件人
           </td>
         </tr>
         <tr>
           <td>
             <%= @order.shopping_name %> - <%= @order.shopping_address %>
           </td>
         </tr>
       </tbody>
     </table>


   </div>
 </div>
