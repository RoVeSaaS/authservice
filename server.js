require('dotenv').config();
const express = require('express');
const { PORT, WORKOS_SECRET, WORKOS_CLIENT_ID, CORS_OPTIONS, WORKOS_REDIRECT_URI } = require('./appConfig');
const { WorkOS } = require('@workos-inc/node');
const cors = require('cors');
const { verifyToken, extractBearerToken } = require('./util');
const errorHandler = require('./middleware');

const server = express();
const workos = new WorkOS(WORKOS_SECRET);

server.use(express.json())
server.use(cors(CORS_OPTIONS));

server.get("/authURL", async (req, res, next) => {
  try {
    const callbackURL = await workos.userManagement.getAuthorizationUrl({
      provider: 'authkit',
      redirectUri: WORKOS_REDIRECT_URI,
      clientId: WORKOS_CLIENT_ID
    });
    if (callbackURL) {
      res.status(200).json({ status: 'SUCCESS', callbackURL: callbackURL });
    } else {
      res.status(500).json({ status: 'FAILED', callbackURL: null });
    }
  } catch (err) {
    next(err);
  }
});

server.post("/workos/callback", async (req, res, next) => {
  try {
    const code = req.body.code;
    const { user, organizationId, accessToken } = await workos.userManagement.authenticateWithCode({
      code,
      clientId: WORKOS_CLIENT_ID,
    });
    const response = {
      status: 'SUCCESS',
      user: user ? { ...user } : null,
      organizationId: organizationId || null,
      accessToken: accessToken || null
    }
    res.json({ ...response });
  } catch (err) {
    next(err);
  }
});

server.get("/refresh", async (req, res, next) => {
  try {
    const accessToken = extractBearerToken(req?.headers?.authorization);
    if (accessToken) {
      const tokenRes = await verifyToken(accessToken, workos);
      if (tokenRes.status && tokenRes.token) {
        const { sub = null } = tokenRes?.token
        if (sub) {
          const userData = await workos.userManagement.getUser(sub);
          if (userData) {
            res.json({ status: 'SUCCESS', data: { ...userData } })
          } else {
            res.json({ status: 'FAILED', data: null });
          }
        }
      } else {
        res.json({ status: 'FAILED', message: tokenRes?.message || "Something went wrong" });
      }
    } else {
      res.json({ status: 'FAILED', message: "Invalid Token" });
    }
  } catch (err) {
    next(err);
  }
});

server.use(errorHandler)

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
})