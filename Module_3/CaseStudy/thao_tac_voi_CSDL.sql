use furama_resort;

-- Yêu cầu 2
select * from nhan_vien where (ho_ten like '%H' or '%T' or '%K') or (length(ho_ten) = 15);

-- Yêu cầu 3 
select * from khach_hang;
select * from khach_hang 
	where ((round(datediff(curdate(), ngay_sinh) / 365, 0) > 18) and (round(datediff(curdate(), ngay_sinh) / 365, 0) < 50)) 
		and ((dia_chi like '%Quảng Trị') or (dia_chi like '%Đà Nẵng'));
        
-- Yêu cầu 4 
select khach_hang.ho_ten, count(hop_dong.id_khach_hang) as so_lan_dat from khach_hang 
	inner join hop_dong on hop_dong.id_khach_hang = khach_hang.id_khach_hang
    inner join loai_khach_hang on loai_khach_hang.id_loai_khach_hang = khach_hang.id_loai_khach_hang
    where loai_khach_hang.loai_khach_hang = 'Diamond'
		group by khach_hang.ho_ten
			order by so_lan_dat;   
            
-- Yêu cầu 5
select khach_hang.id_khach_hang, khach_hang.ho_ten, loai_khach_hang.loai_khach_hang, hop_dong.id_hop_dong, loai_dich_vu.ten_loai_dich_vu,
	hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc,	dich_vu.chi_phi_thue + dich_vu_di_kem.don_vi*dich_vu_di_kem.gia as tong_tien from hop_dong
    right join khach_hang on khach_hang.id_khach_hang = hop_dong.id_khach_hang
    left join loai_khach_hang on loai_khach_hang.id_loai_khach_hang = khach_hang.id_loai_khach_hang
    left join dich_vu on dich_vu.id_dich_vu = hop_dong.id_dich_vu
    left join loai_dich_vu on loai_dich_vu.id_loai_dich_vu = dich_vu.id_loai_dich_vu
    left join hop_dong_chi_tiet on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
    left join dich_vu_di_kem on dich_vu_di_kem.id_dich_vu_di_kem = hop_dong_chi_tiet.id_dich_vu_di_kem;

-- Yêu cầu 6
select dich_vu.id_dich_vu, dich_vu.ten_dich_vu, dich_vu.dien_tich, dich_vu.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc from dich_vu
	inner join loai_dich_vu on loai_dich_vu.id_loai_dich_vu = dich_vu.id_loai_dich_vu
    inner join hop_dong on hop_dong.id_dich_vu = dich_vu.id_dich_vu
    where year(hop_dong.ngay_lam_hop_dong) <=2018 or (year(hop_dong.ngay_lam_hop_dong) = 2019 and month(hop_dong.ngay_lam_hop_dong) >3) or year(hop_dong.ngay_lam_hop_dong) >=2020;
    
-- Yêu cầu 7
select hop_dong.id_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, loai_dich_vu.ten_loai_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc from dich_vu
	inner join loai_dich_vu on loai_dich_vu.id_loai_dich_vu = dich_vu.id_loai_dich_vu
    inner join hop_dong on hop_dong.id_dich_vu = dich_vu.id_dich_vu
    inner join khach_hang on khach_hang.id_khach_hang = hop_dong.id_khach_hang
    where (year(hop_dong.ngay_lam_hop_dong) = 2018) and (year(hop_dong.ngay_lam_hop_dong) != 2019);
    
-- Yêu cầu 8
-- Cách 1
select ho_ten from khach_hang group by ho_ten having count(ho_ten) = 1;
-- Cách 2
select ho_ten from khach_hang where ho_ten in (select ho_ten from khach_hang group by ho_ten having count(ho_ten) = 1);
-- Cách 3
select ho_ten from khach_hang kh where not exists ( select 1 from khach_hang khh where khh.ho_ten = kh.ho_ten limit 1, 1);

-- Yêu cầu 9
select month(ngay_lam_hop_dong) as 'Tháng', count(month(ngay_lam_hop_dong)) as 'Số khách hàng đặt phòng' from hop_dong group by ngay_lam_hop_dong having year(ngay_lam_hop_dong) = 2019;

-- Yêu cầu 10
select hop_dong.id_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, count(hop_dong_chi_tiet.id_hop_dong) as so_luong_dich_vu_di_kem from hop_dong
	inner join hop_dong_chi_tiet on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
    group by hop_dong_chi_tiet.id_hop_dong;
    
-- Yêu cầu 11
select khach_hang.ho_ten, dich_vu_di_kem.ten_dich_vu_di_kem from khach_hang
	inner join hop_dong  on hop_dong.id_khach_hang = khach_hang.id_khach_hang
    inner join hop_dong_chi_tiet on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
    inner join dich_vu_di_kem on dich_vu_di_kem.id_dich_vu_di_kem = hop_dong_chi_tiet.id_dich_vu_di_kem
    where (khach_hang.dia_chi like '%Vinh%') or (khach_hang.dia_chi like '%Quảng Ngãi%');
    
-- Yêu cầu 12
select hop_dong.id_hop_dong, nhan_vien.ho_ten, khach_hang.ho_ten, khach_hang.so_dien_thoai, dich_vu.ten_dich_vu, 
	count(hop_dong_chi_tiet.id_hop_dong) as so_luong_dich_vu_di_kem, hop_dong.tien_dat_coc from hop_dong
		inner join nhan_vien on nhan_vien.id_nhan_vien = hop_dong.id_nhan_vien
        inner join khach_hang on khach_hang.id_khach_hang = hop_dong.id_khach_hang
        inner join dich_vu on dich_vu.id_dich_vu = hop_dong.id_hop_dong
        left join hop_dong_chi_tiet on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
        where (year(hop_dong.ngay_lam_hop_dong) = 2019) and (month(hop_dong.ngay_lam_hop_dong) >= 10)
        group by hop_dong_chi_tiet.id_hop_dong;
        
-- Yêu cầu 13
select dich_vu_di_kem.id_dich_vu_di_kem, ten_dich_vu_di_kem from dich_vu_di_kem
	inner join hop_dong_chi_tiet on hop_dong_chi_tiet.id_dich_vu_di_kem = dich_vu_di_kem.id_dich_vu_di_kem
    inner join hop_dong on hop_dong.id_hop_dong = hop_dong_chi_tiet.id_hop_dong
    group by dich_vu_di_kem.id_dich_vu_di_kem
    order by count(dich_vu_di_kem.id_dich_vu_di_kem) desc limit 1;
    
-- Yêu cầu 14
select hop_dong.id_hop_dong, dich_vu.ten_dich_vu, dich_vu_di_kem.ten_dich_vu_di_kem, count(hop_dong_chi_tiet.id_dich_vu_di_kem) as so_lan_su_dung from hop_dong
	inner join dich_vu on dich_vu.id_dich_vu = hop_dong.id_dich_vu
    inner join hop_dong_chi_tiet on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
	inner join dich_vu_di_kem on dich_vu_di_kem.id_dich_vu_di_kem = hop_dong_chi_tiet.id_dich_vu_di_kem
    group by dich_vu_di_kem.id_dich_vu_di_kem having so_lan_su_dung = 1;
    
-- Yêu cầu 15
select nhan_vien.id_nhan_vien, nhan_vien.ho_ten, trinh_do.ten_trinh_do, bo_phan.ten_bo_phan, nhan_vien.so_dien_thoai, nhan_vien.dia_chi, count(hop_dong.id_nhan_vien) as so_lan from nhan_vien
	inner join trinh_do on trinh_do.id_trinh_do = nhan_vien.id_trinh_do
    inner join bo_phan on bo_phan.id_bo_phan = nhan_vien.id_bo_phan
    inner join hop_dong on hop_dong.id_nhan_vien = nhan_vien.id_nhan_vien
    where (year(hop_dong.ngay_lam_hop_dong) >= 2018) and (year(hop_dong.ngay_lam_hop_dong) >= 2019)
    group by nhan_vien.id_nhan_vien having so_lan = 1;
    
-- Yêu cầu 16
    delete from nhan_vien
        where nhan_vien.id_nhan_vien not in (
			select * from (select nhan_vien.id_nhan_vien from  nhan_vien
				inner join hop_dong on hop_dong.id_nhan_vien = nhan_vien.id_nhan_vien
            ) as x
        );
    
    
    
    
