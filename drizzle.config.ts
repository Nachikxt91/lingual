import "dotenv/config"
import type {Config} from "drizzle-kit"

export default{
    schema:"./db/schema.ts",
    dialect: "postgresql",
    out:"./drizzle",
    dbCredentials:{
        url: "postgresql://neondb_owner:npg_o9ecnzkRgQ1J@ep-raspy-night-a4url1bw-pooler.us-east-1.aws.neon.tech/neondb?sslmode=require",
    },
} satisfies Config;