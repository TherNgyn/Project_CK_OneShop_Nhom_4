package com.oneshop.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;

import org.hibernate.validator.internal.util.stereotypes.Lazy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.FluentQuery.FetchableFluentQuery;
import org.springframework.stereotype.Service;

import com.oneshop.repository.OrderItemRepository;
import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IProductService;

@Service
public class OrderItemServiceImpl implements IOrderItemService {

	@Autowired
	OrderItemRepository orderItemRepository;
	
	@Autowired
	IProductService productService;

	@Autowired
	 @Lazy
	    private IOrderItemService orderItemService;

	
	@Override
	public <S extends OrderItem> S save(S entity) {
		return orderItemRepository.save(entity);
	}

	@Override
	public <S extends OrderItem> Optional<S> findOne(Example<S> example) {
		return orderItemRepository.findOne(example);
	}

	@Override
	public List<OrderItem> findAll() {
		return orderItemRepository.findAll();
	}

	@Override
	public Page<OrderItem> findAll(Pageable pageable) {
		return orderItemRepository.findAll(pageable);
	}

	@Override
	public List<OrderItem> findAll(Sort sort) {
		return orderItemRepository.findAll(sort);
	}

	@Override
	public List<OrderItem> findAllById(Iterable<Integer> ids) {
		return orderItemRepository.findAllById(ids);
	}

	@Override
	public Optional<OrderItem> findById(Integer id) {
		return orderItemRepository.findById(id);
	}

	@SuppressWarnings("deprecation")
	@Override
	public void deleteInBatch(Iterable<OrderItem> entities) {
		orderItemRepository.deleteInBatch(entities);
	}

	@Override
	public void deleteAllInBatch(Iterable<OrderItem> entities) {
		orderItemRepository.deleteAllInBatch(entities);
	}

	@Override
	public <S extends OrderItem, R> R findBy(Example<S> example, Function<FetchableFluentQuery<S>, R> queryFunction) {
		return orderItemRepository.findBy(example, queryFunction);
	}

	@Override
	public long count() {
		return orderItemRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		orderItemRepository.deleteById(id);
	}

	@Override
	public OrderItem getOne(Integer id) {
	    return orderItemRepository.getReferenceById(id);
	}


	@Override
	public OrderItem getById(Integer id) {
	    return orderItemRepository.getReferenceById(id);
	}


	@Override
	public void deleteAll() {
		orderItemRepository.deleteAll();
	}
	
	@Override
	public List<OrderItem> getOrderItemByStore(Store store) {

		List<Product> products = productService.findProductByStore(store);
		List<OrderItem> orderItems = orderItemService.findAll();
		List<OrderItem> temp = new ArrayList<OrderItem>();
		for (Product product : products) {

			for (OrderItem orderItem : orderItems) {
				if (product.getId().equals(orderItem.getProduct().getId())) {
					temp.add(orderItem);
				}
			}
		}
		if (!temp.isEmpty()) {
			return temp;
		}
		return null;
	}

	@Override
	public Double doanhThu(List<OrderItem> orderitems) {
		Double doanhthu = 0.0;
		for (OrderItem orderItem : orderitems) {
			doanhthu = doanhthu + orderItem.getCount() * orderItem.getProduct().getPrice();
		}
		return doanhthu;
	}


	@Override
	public List<OrderItem> findByOrder(Order Order) {
		return orderItemRepository.findByOrder(Order);
	}

	@Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        return orderItemRepository.findAllByOrderId(orderId);
    }

	public List<OrderItem> findByOrderId(Integer orderId) {
	    return orderItemRepository.findByOrder_Id(orderId);
	}


}
