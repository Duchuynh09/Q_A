import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: Home,
    },
    {
      path: "/:id",
      name: "editQuest",
      component: () => import("../views/EditQuest.vue"),
      meta: { requiresAuth: true },
      // beforeEnter(to, from, next) {
      //   const login = localStorage.getItem("logined");
      //   if (!login && to.meta.requiresAuth) {
      //     next({ name: "login" });
      //   }
      // },
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/Login.vue"),
    },
    {
      path: "/register",
      name: "register",
      component: () => import("../views/Register.vue"),
    },
    {
      path: "/addQuest",
      name: "addQuest",
      component: () => import("../views/AddQuest.vue"),
      meta: { requiresAuth: true },
    },
  ],
});
router.beforeEach((to, from) => {
  // console.log(to.meta.requiresAuth);
  // console.log(localStorage.getItem("login"));
  if (to.meta.requiresAuth && !localStorage.getItem("login")) {
    return { name: "login" };
  }
});
export default router;
