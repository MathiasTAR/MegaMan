if (instance_exists(oPlayer)){
	if (oPlayer._vidaPlayer > 0){
		switch (oVenenoChaoNeuroToxica.FaseVenenoChao){
			case 0:
				if (y <= 1609){
					cameraUPD(oCamera)
				}else {
					y --;
					cameraUPD(oCamera);
				}
			break;
			
			case 1:

			break;
		}
	};
}