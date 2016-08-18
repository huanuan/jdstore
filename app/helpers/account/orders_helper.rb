module Account::OrdersHelper

  def render_payment_method(order)
    #如果没有支付,展示支付按钮
    if !order.is_paid

      content_tag(:div) do
        concat link_to("支付宝支付", pay_with_alipay_order_path(order,payment_method: "ali"), method: :post,
                        class: "btn btn-sm btn-danger")
        concat "/"
        concat link_to("微信支付", pay_with_wechat_order_path(order,payment_method: "wx"), method: :post,
                        class: "btn btn-sm btn-danger",style: "margin-left:10px")
      end

    end
  end

  def render_order_operate(order)
    content_tag(:div) do
      if order.aasm_state == "paid"
        concat link_to("取消订单",appl_cancell_order_account_order_path(order), method: :post)
      elsif order.aasm_state == "shipping"
        concat "已发货"
      elsif order.aasm_state == "shipped"
        concat link_to("退货申请",appl_return_good_account_order_path(order), method: :post)
      elsif order.aasm_state == "refund"
        concat "已退款"
      end

    end
  end

end
