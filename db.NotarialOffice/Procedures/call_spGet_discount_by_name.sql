use db_notarial_office;



# 1
CALL spGet_discount_by_name(CONCAT( 'Осипов', ' ', 'Алексей', ' ', 'Андреевич'));

# 2
CALL spGet_discount_by_name(CONCAT( 'Осипов%'));

# 3
CALL spGet_discount_by_name(CONCAT( '%Егор%'));
