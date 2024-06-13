// src/app/page.tsx
import Layout from "../components/Layout";
import { Container, Box, Grid, Button, Typography } from "@mui/material";
import Link from "next/link";

const Home = () => {
  return (
    <Layout>
      <Box
        sx={{
          position: "relative",
          minHeight: "100vh",
          backgroundImage: "url('/wall.jpg')",
          backgroundSize: "cover",
          backgroundPosition: "center",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}>
        <Container sx={{ position: "relative", zIndex: 1 }}>
          <Box
            sx={{
              position: "relative",
              marginBottom: 4, // Adjust margin as needed
              borderRadius: 4,
              overflow: "hidden",
            }}>
            <img
              src="/welcome.jpg"
              alt="Welcome Image"
              style={{
                width: "100%",
                height: "auto",
                display: "block",
                borderRadius: 4,
              }}
            />
            <Box
              sx={{
                position: "absolute",
                top: "50%",
                left: "50%",
                transform: "translate(-50%, -50%)",
                textAlign: "center",
                width: "100%",
                color: "white",
                zIndex: 1,
              }}>
              <Typography variant="h4">Welcome</Typography>
            </Box>
          </Box>

          <Grid container spacing={4} justifyContent="space-between">
            <Grid item xs={12} sm={6} md={4}>
              <Box
                sx={{
                  height: 200,
                  position: "relative",
                  overflow: "hidden",
                  borderRadius: 4,
                }}>
                <img
                  src="/login.jpg"
                  alt="Login Image"
                  style={{
                    position: "absolute",
                    top: 0,
                    left: 0,
                    width: "100%",
                    height: "100%",
                    objectFit: "cover",
                  }}
                />
                <Link href="/login" passHref>
                  <Button
                    variant="contained"
                    color="primary"
                    sx={{
                      position: "relative",
                      zIndex: 1,
                      width: "100%",
                      height: "100%",
                      borderRadius: 4,
                      backgroundColor: "rgba(0, 0, 0, 0.5)", // Adjust opacity as needed
                      color: "white",
                    }}>
                    Login
                  </Button>
                </Link>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6} md={4}>
              <Box
                sx={{
                  height: 200,
                  position: "relative",
                  overflow: "hidden",
                  borderRadius: 4,
                }}>
                <img
                  src="/register.jpg"
                  alt="Register Image"
                  style={{
                    position: "absolute",
                    top: 0,
                    left: 0,
                    width: "100%",
                    height: "100%",
                    objectFit: "cover",
                  }}
                />
                <Link href="/register" passHref>
                  <Button
                    variant="contained"
                    color="primary"
                    sx={{
                      position: "relative",
                      zIndex: 1,
                      width: "100%",
                      height: "100%",
                      borderRadius: 4,
                      backgroundColor: "rgba(0, 0, 0, 0.5)", // Adjust opacity as needed
                      color: "white",
                    }}>
                    Register
                  </Button>
                </Link>
              </Box>
            </Grid>
          </Grid>
        </Container>
      </Box>
    </Layout>
  );
};

export default Home;
