if (instance_exists(oPlayer)){
	if (oPlayer._vidaPlayer > 0){
		switch (FaseVenenoChao) {
			case 0:
				if (y <= 1770){
					FaseVenenoChao = 1
				}else {
					y --;
				}
			break;
		
			case 1:
			break;
		}
	}
}