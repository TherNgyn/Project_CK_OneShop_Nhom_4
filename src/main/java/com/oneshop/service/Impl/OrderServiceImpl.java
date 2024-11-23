package com.oneshop.service.Impl;


import java.sql.Date;
import java.time.LocalDate;
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
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.repository.OrderRepository;
import com.oneshop.service.IOrderService;
@Service
public class OrderServiceImpl implements IOrderService {
	@Autowired
	OrderRepository orderRepository;
	
	

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
	public Float totalPriceToDay(List<Order> orders, Date date) {
	    Float price = (float) 0;
	    LocalDate targetDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

	    for (Order order : orders) {
	        LocalDate orderDate = order.getCreateat().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

	        if (orderDate.equals(targetDate)) {
	            price += order.getPrice();
	        }
	    }
	    return price;
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public Float getPrice12Month(List<Order> oders, Integer limit) {

		Float totalPrice = (float) 0;

		long millis = System.currentTimeMillis();
		Date date = new Date(millis);

		int y = 12;
		for (Order order : oders) {

			if (order.getCreateat().getMonth() == (date.getMonth()-limit)) {
				totalPrice = totalPrice + order.getPrice();
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
	            LocalDate orderDate = order.getCreateat().toInstant()
	                                        .atZone(ZoneId.systemDefault())
	                                        .toLocalDate();

	            // Kiểm tra tháng
	            if (orderDate.getYear() == currentDate.minusMonths(limit).getYear() &&
	                orderDate.getMonth() == currentDate.minusMonths(limit).getMonth()) {
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
		// TODO Auto-generated method stub
		return orderRepository.findByUser(user);
	}
}
