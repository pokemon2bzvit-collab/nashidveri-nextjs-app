import type { Config } from "tailwindcss";
export default { content: ["./app/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}"], theme: { extend: { colors: { ink: "#1F211C", clay: "#B56C45", sand: "#F5F1E9", pine: "#36523D" }, fontFamily: { display: ["Georgia", "serif"] }, boxShadow: { soft: "0 18px 50px -28px rgba(31,33,28,.32)" } } }, plugins: [] } satisfies Config;
