package com.oneshop.service.Impl;


import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.repository.OrderItemRepository;
import com.oneshop.repository.OrderRepository;
import com.oneshop.service.IOrderService;
@Service
public class OrderServiceImpl implements IOrderService {
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
	OrderItemRepository orderItemRepository;
	
	@Override
    public List<Order> getAllOrdersByCustomer(Integer customerId) {
        return orderRepository.findByUser_Id(customerId);
    }
	
	@Override
    public List<Order> getOrdersByCustomer(Integer customerId, String status) {
        return orderRepository.findByUser_IdAndStatus(customerId, status);
    }
	
	@Override
    public List<OrderItem> getOrderItemsByOrderId(Integer orderId) {
        return orderItemRepository.findByOrder_Id(orderId); 
    }
	
	@Override
	public <S extends Order> S save(S entity) {
		return orderRepository.save(entity);
	}

	@Override
	public <S extends Order> Optional<S> findOne(Example<S> example) {
		return orderRepository.findOne(example);
	}

	@Override
	public List<Order> findAll() {
		return orderRepository.findAll();
	}

	@Override
	public Page<Order> findAll(Pageable pageable) {
		return orderRepository.findAll(pageable);
	}

	@Override
	public List<Order> findAll(Sort sort) {
		return orderRepository.findAll(sort);
	}

	@Override
	public List<Order> findAllById(Iterable<Integer> ids) {
		return orderRepository.findAllById(ids);
	}

	@Override
	public <S extends Order> Page<S> findAll(Example<S> example, Pageable pageable) {
		return orderRepository.findAll(example, pageable);
	}

	@Override
	public Optional<Order> findById(Integer id) {
		return orderRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return orderRepository.existsById(id);
	}

	@Override
	public long count() {
		return orderRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		orderRepository.deleteById(id);
	}

	@Override
	public void delete(Order entity) {
		orderRepository.delete(entity);
	}

	@SuppressWarnings("deprecation")
	@Override
	public Order getById(Integer id) {
		return orderRepository.getById(id);
	}

	@Override
	public void deleteAll() {
		orderRepository.deleteAll();
	}
	
	// viết thêm
	@Override
	public Float totalPrice(List<Order> orders) {
		Float price = (float) 0;
		for (Order order : orders) {
			price = price + order.getPrice();
		}
		return price;
	}
	
	@Override
	public Float totalPriceToDay(List<Order> orders, LocalDate date) {
	    Float price = 0f;

	    for (Order order : orders) {
	        // Convert `LocalDateTime` to `LocalDate` for comparison
	        LocalDate orderDate = order.getCreateat().toLocalDate();

	        if (orderDate.equals(date)) {
	            price += order.getPrice();
	        }
	    }
	    return price;
	}

	
	@Override
	public Float getPrice12Month(List<Order> orders, Integer limit) {

	    Float totalPrice = 0f;

	    // Lấy thời gian hiện tại
	    LocalDateTime now = LocalDateTime.now();

	    for (Order order : orders) {
	        LocalDateTime createAt = order.getCreateat();
	        if (createAt != null) {
	            // So sánh tháng giữa `createAt` và thời gian hiện tại trừ đi `limit`
	            if (createAt.getYear() == now.minusMonths(limit).getYear() &&
	                createAt.getMonthValue() == now.minusMonths(limit).getMonthValue()) {
	                totalPrice += order.getPrice();
	            }
	        }
	    }

	    return totalPrice;
	}

	
	@Override
	public Integer countByCreateat(Date date) {
		return orderRepository.countByCreateat(date);
	}
	
	@Override
	public Float getPrice12MonthOfStore(List<Order> orders, Integer id, Integer limit) {
	    Float totalPrice = (float) 0;

	    // Lấy ngày hiện tại
	    LocalDate currentDate = LocalDate.now();

	    for (Order order : orders) {
	        if (order.getStore().getId().equals(id)) {
	            // Chuyển đổi ngày tạo đơn hàng từ Date sang LocalDate
	            LocalDate orderDate = order.getCreateat().toLocalDate();

	            // Kiểm tra tháng
	            if (orderDate.getYear() == currentDate.getYear() 
	                && orderDate.getMonthValue() >= (currentDate.getMonthValue() - limit)) {
	                totalPrice += order.getPrice();
	            }
	        }
	    }
	    return totalPrice;
	}

	@Override
	public List<Order> findByStore(Store store) {
		// TODO Auto-generated method stub
		return orderRepository.findByStore(store);
	}
	
	@Override
	public long countOrder(List<Order> orders, Store store) {
		long count=0;
		for (Order order : orders) {
			if(order.getStore().getId()==store.getId())
				count++;
		}
		return count;
	}
	
	@Override
	public Float totalPrice(List<Order> orders, Store store) {
		Float price = (float) 0;
		for (Order order : orders) {
			if(order.getStore().getId()==store.getId())
				price = price + order.getPrice();
		}
		return price;
	}
	@Override
	public List<Order> findByUser(User user) {
		return orderRepository.findByUser(user);
	}
	@Override
    public List<Order> getAllOrdersByCustomerAndStore(Integer userId, Store store) {
        return orderRepository.findAllByUserIdAndStore(userId, store);
    }

    @Override
    public List<Order> getOrdersByCustomerAndStore(Integer userId, Store store, String status) {
        return orderRepository.findAllByUserIdAndStoreAndStatus(userId, store, status);
    }

    @Override
    public Order findLatestOrder(User user) {
        return orderRepository.findTopByUserIdOrderByCreateatDesc(user.getId());
    }

	@Override

	public List<Order> getOrdersByCustomer(Integer userId, String status1, String status2) {
		// TODO Auto-generated method stub
		return orderRepository.findOrdersByUserAndStatuses(userId, status1, status2);
	}

	@Override
	public List<Order> searchOrdersByProductName(Integer userId, String productName) {
		// TODO Auto-generated method stub
		return orderRepository.findOrdersByUserAndProductNameNative(userId, "%" + productName + "%");
	}

	@Override
	public List<Order> searchOrdersByProductNameAndStatus(Integer userId, String productName, String status) {
		// TODO Auto-generated method stub
		return orderRepository.findOrdersByUserAndProductNameAndStatusNative(userId, "%" + productName + "%", status);
	}

	public void update(Order order) {
		// Tìm đơn hàng trong DB
        Order existingOrder = orderRepository.findById(order.getId())
                .orElseThrow(() -> new IllegalArgumentException("Order not found with id: " + order.getId()));

        // Cập nhật các thuộc tính
        existingOrder.setUser(order.getUser());
        existingOrder.setStore(order.getStore());
        existingOrder.setDelivery(order.getDelivery());
        existingOrder.setAddress(order.getAddress());
        existingOrder.setPhone(order.getPhone());
        existingOrder.setStatus(order.getStatus());
        existingOrder.setPrice(order.getPrice());
        existingOrder.setOrderItems(order.getOrderItems());
        existingOrder.setUpdateat(LocalDateTime.now()); // Cập nhật thời gian sửa đổi

        // Lưu lại vào DB
        orderRepository.save(existingOrder);
	}
    

}
