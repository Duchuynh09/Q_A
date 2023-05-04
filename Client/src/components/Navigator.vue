<template>
    <nav class="navbar navbar-expand-sm bg-light navbar-light">
        <div class="container-fluid">
            <div class="btn-group">
                <button type="button" class="btn btn-primary">Apple</button>
                <button type="button" class="btn btn-primary">Samsung</button>
                <div class="btn-group">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">Xem them</button>
                    <ul class="dropdown-menu">
                        <li><router-link class="dropdown-item" to="/addQuest" >Them cau hoi</router-link></li>
                        <li><a class="dropdown-item" href="#">Smartphone</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</template>