if (instance_exists(oPlayer)){
	if (y <= 1609){
		cameraUPD(oCamera)
	}else {
		y --;
		cameraUPD(oCamera);
	}
}