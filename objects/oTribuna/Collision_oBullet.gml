if (inv_timer <= 0 and _estado != "Intro" and _estado != "Morto") {
    _vidaBoss -= 1.5;
    instance_destroy(other);
    inv_timer = 10; // tempo de invencibilidade
} else {
    inv_timer--;
}

