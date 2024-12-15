package com.oneshop.service.Impl;


import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.model.MonthlyRevenue;
import com.oneshop.model.RevenueData;
import com.oneshop.model.YearlyRevenue;
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
		return orderRepository.findOrdersByUserAndStatuses(userId, status1, status2);
	}

	@Override
	public List<Order> searchOrdersByProductName(Integer userId, String productName) {
		return orderRepository.findOrdersByUserAndProductNameNative(userId, "%" + productName + "%");
	}

	@Override
	public List<Order> searchOrdersByProductNameAndStatus(Integer userId, String productName, String status) {
		return orderRepository.findOrdersByUserAndProductNameAndStatusNative(userId, "%" + productName + "%", status);
	}

	public void update(Order order) {
        Order existingOrder = orderRepository.findById(order.getId())
                .orElseThrow(() -> new IllegalArgumentException("Order not found with id: " + order.getId()));
        existingOrder.setUser(order.getUser());
        existingOrder.setStore(order.getStore());
        existingOrder.setDelivery(order.getDelivery());
        existingOrder.setAddress(order.getAddress());
        existingOrder.setPhone(order.getPhone());
        existingOrder.setStatus(order.getStatus());
        existingOrder.setPrice(order.getPrice());
        existingOrder.setOrderItems(order.getOrderItems());
        existingOrder.setUpdateat(LocalDateTime.now()); 
        orderRepository.save(existingOrder);
	}

    @Override
    public Order savestatuscancel(Order order) {
        return orderRepository.save(order);
    }
	public List<MonthlyRevenue> calculateMonthlyRevenue(int year) {
        // Fetch orders for the specified year
        List<Order> orders = orderRepository.findOrdersByYear(year);

        // Array to store total revenue for each month (12 months)
        double[] monthlySales = new double[12];

        // Process each order to accumulate revenue by month
        for (Order order : orders) {
            if (order.getPrice() != null && order.getCreateat() != null && order.getStatus().equals("Completed")) {
                int month = order.getCreateat().getMonthValue(); // Get month from createat (1-12)
                monthlySales[month - 1] += order.getPrice(); // Accumulate revenue for the month
            }
        }

        // Convert monthlySales array into MonthlyRevenue objects
        List<MonthlyRevenue> monthlyRevenues = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            monthlyRevenues.add(new MonthlyRevenue(i + 1, monthlySales[i]));
        }

        return monthlyRevenues;
    }
    
	@Override
	public List<Integer> getDistinctYearsFromOrders() {
        // Lấy các năm từ updateat và loại bỏ các giá trị trùng lặp
        return orderRepository.findAll().stream()
                .map(order -> order.getUpdateat().getYear())
                .distinct()
                .sorted((y1, y2) -> Integer.compare(y2, y1)) // Sắp xếp giảm dần
                .collect(Collectors.toList());
    }
	
	@Override
	public List<YearlyRevenue> calculateYearlyRevenue() {
	    List<Integer> years = getDistinctYearsFromOrders();

	    List<YearlyRevenue> yearlyRevenues = new ArrayList<>();
	    
	    for (Integer year : years) {
	        List<Order> orders = orderRepository.findOrdersByYear(year);

	        double totalRevenue = 0;

	        for (Order order : orders) {
	            if (order.getPrice() != null && order.getCreateat() != null && order.getStatus().equals("Completed")) {
	                totalRevenue += order.getPrice(); 
	            }
	        }

	        yearlyRevenues.add(new YearlyRevenue(year, totalRevenue));
	    }

	    return yearlyRevenues;
	}
	
	@Override

	public long countPendingOrders() {
        return orderRepository.countByStatus("processing_1");
    }
	@Override
	public List<Order> getOrdersByStore(Integer storeId) {
        return orderRepository.findAllByStoreId(storeId);
    }
	@Override
	public List<Order> getOrdersByStoreAndStatus(Store store, String status) {
		 return orderRepository.findDistinctByOrderItems_Product_StoreAndStatus(store, status);
	}
	@Override
	public List<Order> getOrdersByStoreAndStatus2(Store store, String status, String status2) {
		 return orderRepository.getOrdersByStoreAndStatuses(store.getId(), status, status2);
	}
	@Override
	public List<Order> getLatestOrders() {
        return orderRepository.findLatestOrders();
    }
	@Override
	public long getNewOrderCount() {
        return orderRepository.countNewOrders();
    }
	
	@Override
	public Double viewSumRevenue() {
        return orderRepository.findTotalRevenue();
    }
	
	@Override
	public Double getTodayRevenue() {
        LocalDateTime startOfDay = LocalDateTime.now().with(LocalTime.MIN);
        LocalDateTime endOfDay = LocalDateTime.now().with(LocalTime.MAX);
        return orderRepository.findTodayRevenue(startOfDay, endOfDay);
    }
	@Override
	public List<Order> getOrdersInTransit() {
        return orderRepository.findOrdersInTransit();
    }
	@Override
    public void updateOrderStatus(Integer orderId, String status) {
        Order order = orderRepository.getById(orderId);
        order.setStatus(status);
        orderRepository.save(order);
    }

	public List<Order> findOrders(String status, String searchTerm) {
	    // Cả status và searchTerm đều null, trả về tất cả đơn hàng
	    if (!StringUtils.hasText(status) && !StringUtils.hasText(searchTerm)) {
	        return orderRepository.findAll();
	    }

	    // Nếu status null, tìm kiếm theo searchTerm (số điện thoại hoặc tên khách hàng)
	    if (!StringUtils.hasText(status)) {
	        return orderRepository.findByPhoneContainingIgnoreCaseOrUserFirstNameContainingIgnoreCaseOrUserLastNameContainingIgnoreCase(searchTerm, searchTerm, searchTerm);
	    }

	    // Nếu searchTerm null, tìm kiếm theo status
	    if (!StringUtils.hasText(searchTerm)) {
	        return orderRepository.findByStatusIgnoreCase(status);
	    }

	    // Nếu cả hai đều có giá trị, tìm theo cả status và searchTerm (số điện thoại hoặc tên khách hàng)
	    return orderRepository.findByStatusIgnoreCaseAndPhoneContainingIgnoreCaseOrUserFirstNameContainingIgnoreCaseOrUserLastNameContainingIgnoreCase(status, searchTerm, searchTerm, searchTerm);
	}

}
